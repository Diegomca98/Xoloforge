terraform {
  backend "s3" {
    bucket = "xoloforge-tfstate-bkt"
    key = "dev/phase_2/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "xoloforge-tf-locks"
    encrypt = true
  }
}