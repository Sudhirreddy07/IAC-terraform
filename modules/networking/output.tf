output "public-subnets" {
    value = local.pub_sub_id
}

output "private-subnets" {
    value = local.pri_sub_id
}
output "vpc_id" {
    value = aws_vpc.main.id
  
}


