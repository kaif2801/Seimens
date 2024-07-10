provider "aws" {
    region = "ap-south-1"
}


terraform{
    backend "s3"
    {
        bucket = "467.devops.candidate.exam"
        Region: "ap-south-1"
        Key: "Kaif Raza.Shaikh"
    }
}


data "aws_vpc" "selected"{
    id = "vpc-06b326e20d7db55f9"
}


resource "aws_subnet" 
"private_subnet" {

    count = 1
    vpc_id = data.aws_vpc.selected.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
}

resource "aws_security_group" 
"lambda_sg"{
    vpc_id = data.aws_vpc.selected.id

     ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_block = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_block = ["0.0.0.0/0"]
    }
}


resource "aws_lambda_function" 
"my_lambda_function" {
    function_name = "my_lambda_function"
    handler = "lambda_function.lambda_handler"
    runtime = "python3.8"
    role = "DevOps-Candidate-Lambda-Role"

    vpc_config{
    subnet_ids = [aws_subnet.private_subnet.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
       }
}


   