output "caller_arn" {
  description = "Terraform이 사용하는 IAM 주체"
  value       = data.aws_caller_identity.current.arn
}

output "region" {
  description = "배포 대상 리전"
  value       = data.aws_region.current.region
}

output "vpc_id" {
  description = "생성된 VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "퍼블릭 서브넷 ID"
  value       = { for k, s in aws_subnet.public : k => s.id }
}

output "private_subnet_ids" {
  description = "프라이빗 서브넷 ID"
  value       = { for k, s in aws_subnet.private : k => s.id }
}
