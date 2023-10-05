variable "ami_id" {
    default = "ami-01c647eace872fc02"
}

variable "vpc_cidrs" {
  default = "10.20.0.0/16"
}

variable "public-subnets" {
}

variable "instance_type" {
  default = "t2.micro"
}


variable "security-ids" {
  type = list(string)
}