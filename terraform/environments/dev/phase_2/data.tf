# environments/dev/phase2/data.tf
data "terraform_remote_state" "phase1" {
  backend = "s3"
  config = {
    bucket         = "xoloforge-terraform-state"
    key            = "dev/phase1/terraform.tfstate"  # reads phase1's state
    region         = "us-east-1"
    dynamodb_table = "xoloforge-terraform-locks"
  }
}