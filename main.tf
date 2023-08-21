resource "aws_vpc" "tf-test-vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "tf-test"
  }
}

resource "aws_subnet" "tft-subnet1_public" {
  vpc_id                  = aws_vpc.tf-test-vpc.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "tft-public"
  }
}

resource "aws_internet_gateway" "tf-test-int_gate" {
  vpc_id = aws_vpc.tf-test-vpc.id

  tags = {
    Name = "tft-igw"
  }
}

resource "aws_route_table" "tft-public-rt" {
  vpc_id = aws_vpc.tf-test-vpc.id

  tags = {
    Name = "tft-pb-rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.tft-public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tf-test-int_gate.id
}

resource "aws_route_table_association" "tft-public-assoc" {
  subnet_id      = aws_subnet.tft-subnet1_public.id
  route_table_id = aws_route_table.tft-public-rt.id
}

resource "aws_security_group" "tft-public-SG" {
  name        = "tft-public-SG"
  description = "Allow all traffic from my IP"
  vpc_id      = aws_vpc.tf-test-vpc.id

  ingress {
    description = "All traffic from my IP"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All Traffic Outbound"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tft-public-SG"
  }
}

resource "aws_key_pair" "tft-auth" {
  key_name   = "tft-key"
  public_key = file("~/.ssh/tft-key.pub")
}


resource "aws_instance" "ubuntu-tft" {
  ami                    = data.aws_ami.server_ami.id
  instance_type          = "t2.large"
  key_name               = aws_key_pair.tft-auth.id
  vpc_security_group_ids = [aws_security_group.tft-public-SG.id]
  subnet_id              = aws_subnet.tft-subnet1_public.id
  user_data              = file("userdata.tpl")

  
  root_block_device {
    encrypted = true
    volume_size = 15
  }

  tags = {
    Name = "tft-test"
  }
}
