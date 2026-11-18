# 인증·리전 확인용 data source (읽기 전용)
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  name_prefix = "${var.project}-${var.env}" # ota-dev
}

# ── VPC ──────────────────────────────────────────────
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true # VPC 내부 DNS 서버 사용
  enable_dns_hostnames = true # VPC Endpoint(11/24)·서버 이름 해석에 필요

  tags = {
    Name = "${local.name_prefix}-vpc"
  }
}

# AWS가 자동 생성하는 기본 보안그룹의 규칙을 모두 비운다.
# (ingress/egress 블록이 없으면 Terraform이 기존 규칙을 전부 삭제)
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.name_prefix}-default-sg-locked"
  }
}

# ── 서브넷 ───────────────────────────────────────────
resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = false # 공인 IP 자동 할당 금지 (필요한 리소스에만 명시적으로)

  tags = {
    Name = "${local.name_prefix}-${each.key}"
    Tier = "public"
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${local.name_prefix}-${each.key}"
    Tier = "private"
  }
}

# ── 인터넷 게이트웨이 ────────────────────────────────
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.name_prefix}-igw"
  }
}

# ── 라우팅: 퍼블릭 (0.0.0.0/0 → IGW) ─────────────────
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${local.name_prefix}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# ── 라우팅: 프라이빗 (local 경로만, 외부로 나가는 길 없음) ──
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.name_prefix}-private-rt"
  }
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
