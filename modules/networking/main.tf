resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    tags = var.project_tags
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = var.project_tags
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = var.project_tags
}

resource "aws_subnet" "main" {
  count = var.subnet_count
  availability_zone = local.az[count.index]
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_public_cidrs[count.index]
  tags = var.project_tags
}



resource "aws_route_table_association" "public" {
  count = var.subnet_count
  subnet_id      = aws_subnet.main.*.id[count.index]
  route_table_id = aws_route_table.main.id
}

#create of private subnet

resource "aws_subnet" "private" {
  count = var.subnet_count
  availability_zone = local.az[count.index]
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_private_cidrs[count.index]
  tags = var.project_tags
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id  
}


resource "aws_route_table_association" "private" {
  count = var.subnet_count
  subnet_id      = aws_subnet.private.*.id[count.index]
  route_table_id = aws_route_table.private.id
}





#create a nat gateway in public and route to private subnet

resource "aws_eip" "nat_eip" {             #create a elastic ip and allocate it                
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.main.*.id[0]
}

resource "aws_route" "route_to_private_subnet" {
  route_table_id = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
  
}