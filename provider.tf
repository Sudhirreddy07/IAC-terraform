provider "aws" {
  region = "us-east-1"
}

variable "project_tags" {
  default = {
    Name = "final_iac"
  }
  
}