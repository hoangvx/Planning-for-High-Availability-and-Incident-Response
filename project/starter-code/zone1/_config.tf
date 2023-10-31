terraform {
   backend "s3" {
     bucket = "udacity-tf-hoangvx"
     key    = "terraform/terraform.tfstate"
     region = "us-east-2"
   }

   required_providers {
     aws = {
       source  = "hashicorp/aws"
       version = ">= 2.7.0"
     }
   }
 }

 provider "aws" {
   region = "us-east-2"
   
   default_tags {
     tags = local.tags
   }
 }

 provider "aws" {
  alias  = "usw1"
  region = "us-west-1"
}