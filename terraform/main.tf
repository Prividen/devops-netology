provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = [
      "hvm"]
  }

  owners = [
    "099720109477"]
  # Canonical
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_security_group" "ssh_enabled" {
  name = "launch-wizard-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}


module "ec2-instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "2.19.0"

  name = "test1-module"
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids = ["${data.aws_security_group.ssh_enabled.id}"]
  key_name = "mk-rsa"

  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_size = 5
      volume_type = "gp2"
      delete_on_termination = true
    }
  ]

  tags = {
    Name = "TestInstance1"
    Project = "Netology"
    UsedModule = "Yes"
  }
}

