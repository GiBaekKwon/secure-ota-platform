# 아직 리소스 없음. 인증·리전 확인용 data source만 둔다 (읽기 전용, 과금 없음).
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
