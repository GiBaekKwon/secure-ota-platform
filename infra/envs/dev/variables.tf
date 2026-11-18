variable "project" {
  description = "프로젝트 이름 (태그·리소스 이름 접두사)"
  type        = string
  default     = "ota"
}

variable "env" {
  description = "환경 이름"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS 리전"
  type        = string
  default     = "ap-northeast-2"
}

variable "aws_profile" {
  description = "로컬 AWS CLI 프로필 이름 (자격 증명 자체가 아님)"
  type        = string
  default     = "ota"
}

variable "vpc_cidr" {
  description = "VPC CIDR 대역"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "퍼블릭 서브넷 (키 = 이름 접미사)"
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {
    "public-a" = { cidr = "10.0.1.0/24", az = "ap-northeast-2a" }
    "public-c" = { cidr = "10.0.2.0/24", az = "ap-northeast-2c" }
  }
}

variable "private_subnets" {
  description = "프라이빗 서브넷 (키 = 이름 접미사)"
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {
    "private-a" = { cidr = "10.0.11.0/24", az = "ap-northeast-2a" }
    "private-c" = { cidr = "10.0.12.0/24", az = "ap-northeast-2c" }
  }
}
