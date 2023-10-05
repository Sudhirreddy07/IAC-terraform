variable "vpc_cidr" {
    default = "10.20.0.0/16" 
}


variable "subnet_count" {
    default = 3
}

variable "subnet_public_cidrs" {
  default = ["10.20.0.0/24" , "10.20.1.0/24" ,"10.20.2.0/24"]
}

variable "subnet_private_cidrs" {
  default = ["10.20.3.0/24" , "10.20.4.0/24" ,"10.20.5.0/24"]
}


variable "project_tags" {
  
}

variable "security-ids" {
  
}