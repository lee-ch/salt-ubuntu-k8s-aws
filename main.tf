provider "aws" {
    region                  = "us-west-2"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "default"
}

resource "aws_vpc" "k8s_dev_vpc" {
    cidr_block = "10.16.0.0/16"

    tags = {
        Name = "Kubernetes Dev VPC"
    }
}

resource "aws_subnet" "k8s_dev_subnet_1a" {
    vpc_id            = aws_vpc.k8s_dev_vpc.id
    cidr_block        = "10.16.1.0/24"
    availability_zone = "us-west-2a"

    tags = {
        Name = "Kubernetes Dev Subnet 1a"
    }
}
l
resource "aws_subnet" "k8s_dev_subnet_1b" {
    vpc_id            = aws_vpc.k8s_dev_vpc.id
    cidr_block        = "10.16.2.0/24"
    availability_zone = "us-west-2a"

    tags = {
        Name = "Kubernetes Dev Subnet 1b"
    }
}

resource "aws_instance" "k8s_master_dev_1a" {
    ami           = "ami-000d6375f955d3d80"
    instance_type = "t2.micro"
    subnet_id     = aws_subnet.k8s_dev_subnet_1a.id

    tags = {
        Name = "Kubernetes Dev"
    }
}