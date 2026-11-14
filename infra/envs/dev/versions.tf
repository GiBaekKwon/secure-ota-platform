terraform {
  required_version = ">= 1.9.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # state는 당분간 로컬에 둔다 (11/17에 state 개념 학습 후 원격 backend 검토).
}
