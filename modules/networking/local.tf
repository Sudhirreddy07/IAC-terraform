locals {
  az = data.aws_availability_zones.azs.names
  pub_sub_id = aws_subnet.main.*.id
  pri_sub_id = aws_subnet.private.*.id

}