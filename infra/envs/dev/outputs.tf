output "caller_arn" {
  description = "Terraform이 사용하는 IAM 주체"
  value       = data.aws_caller_identity.current.arn
}

output "region" {
  description = "배포 대상 리전"
  value       = data.aws_region.current.region
}
