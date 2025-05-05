provider "aws" {
  region     = "us-east-1"
  access_key = "Add your access key"
  secret_key = "Add your seceret key"
}

# Fetch existing security group
data "aws_security_group" "project_sg" {
  name = "launch-wizard-3"
}

# Create Master Node
resource "aws_instance" "k_master" {
  ami                    = "ami-0f9de6e2d2f067fca" # your custom AMI
  instance_type          = "t2.medium"
  key_name               = "k8s"
  vpc_security_group_ids = [data.aws_security_group.project_sg.id]

  tags = {
    Name = "k-Master/JM"
  }
}

# Create Worker Node 1
resource "aws_instance" "k_s1" {
  ami                    = "ami-0f9de6e2d2f067fca" # your custom AMI
  instance_type          = "t2.micro"
  key_name               = "k8s"
  vpc_security_group_ids = [data.aws_security_group.project_sg.id]

  tags = {
    Name = "k-S1"
  }
}

# Create Worker Node 2
resource "aws_instance" "k_s2" {
  ami                    = "ami-0f9de6e2d2f067fca" # your custom AMI
  instance_type          = "t2.micro"
  key_name               = "k8s"
  vpc_security_group_ids = [data.aws_security_group.project_sg.id]

  tags = {
    Name = "K-S2"
  }
