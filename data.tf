
data "aws_availability_zones" "azs" {
  state = "available"
}

data "aws_subnet" "subnet_az1" {
  availability_zone = data.aws_availability_zones.azs.names[0]
  filter {
    name   = "tag:Name"
    values = ["*${var.subnet}*"]
  }
}

data "aws_subnet" "subnet_az2" {
  availability_zone = data.aws_availability_zones.azs.names[1]
  filter {
    name   = "tag:Name"
    values = ["*${var.subnet}*"]
  }
}

data "aws_subnet" "subnet_az3" {
  availability_zone = data.aws_availability_zones.azs.names[2]
  filter {
    name   = "tag:Name"
    values = ["*${var.subnet}*"]
  }
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["*${var.environment}*"]
  }
}