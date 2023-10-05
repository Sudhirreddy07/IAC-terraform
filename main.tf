module "jhc-vpc" {
  source = "./modules/networking"
  project_tags = var.project_tags
  security-ids = module.security-group
}

#module "jhc-rds" {
  #source      = "./modules/rds"
  #subnet-ids  = module.jhc-vpc.private-subnets

#}

module "security-group" {
  source = "./modules/security groups"
  vpc_id = module.jhc-vpc.vpc_id
  vpc_ingress_rules = {
    "22" = {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "allow ssh within organization"
    },
    "80" = {
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "allow 80 everywhere"
    }
  }
}

module "jhc_ec2" {
  source = "./modules/EC2 instance"
  security-ids = module.security-group.security-ids
  public-subnets  = module.jhc-vpc.public-subnets
}

module "jhc_alb" {
  source = "./modules/alb"
  vpc_id = module.jhc-vpc.vpc_id
  public-subnets  = module.jhc-vpc.public-subnets
  security-ids = module.security-group.security-ids
  targetec2 = module.jhc_ec2.targetec2


}