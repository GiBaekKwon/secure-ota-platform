provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile # 키는 ~/.aws/credentials 에만. 코드에 넣지 않는다.

  default_tags {
    tags = {
      Project   = var.project
      Env       = var.env
      ManagedBy = "terraform"
    }
  }
}
