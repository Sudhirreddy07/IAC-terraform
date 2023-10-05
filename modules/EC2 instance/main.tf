resource "aws_instance" "main" {
  ami                         = var.ami_id
  associate_public_ip_address = true
  instance_type               = var.instance_type
  subnet_id                   = var.public-subnets[0]
  availability_zone           = "us-east-1a"
  security_groups             = var.security-ids

  key_name      = "server" 
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              service httpd start
              chkconfig httpd on
              echo "<html><body><h1>Hello from EC2 instance with Apache</h1></body></html>" > /var/www/html/index.html
              EOF

  tags = {
    Name       = "terraform_instance"
  }

}