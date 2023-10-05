variable "lb-name" {
  default = "alb-demo"
}

variable "port" {
  default = "80"
}

variable "protocal" {
  default = "HTTP"
}

variable "vpc_id" {
  
}

variable "public-subnets" {
  
}

variable "security-ids" {
  type = list(string)
}

variable "targetec2" { 
}