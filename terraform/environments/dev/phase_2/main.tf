locals {
  environment = "dev"
  common_tags = {
    Project = var.project_name
    Environment = local.environment
    ManagedBy = "Terraform"
    Repository = "Xoloforge"
    DeploymentPhase = "Phase 2"
  }
}

/*************************/
/******** Route53 ********/
/*************************/

/*************************************/
/******** End Route53 Section ********/
/*************************************/




/*************************/
/******** Secrets ********/
/*************************/

/*************************************/
/******** End Secrets Section ********/
/*************************************/
