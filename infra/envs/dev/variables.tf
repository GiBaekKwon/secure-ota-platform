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
