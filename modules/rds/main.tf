resource "aws_db_instance" "RDS" {
  identifier            = var.db-name
  allocated_storage    = var.allow-storage
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name =  var.rds_name
  password             =  var.db-password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true

  vpc_security_group_ids =[var.security_id]  # Security group ID(s)
  db_subnet_group_name = aws_db_subnet_group.rds.name # Subnet group name

  tags = {
    Name = "Example RDS"
  }
}

resource "aws_db_subnet_group" "rds" {
    name = "rds-subnet-group"
    subnet_ids = var.subnet-ids
    tags = {
        Name = "rds-subnet-groups"
    }
  
}