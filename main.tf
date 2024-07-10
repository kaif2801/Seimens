
#Define VPC
resource "aws_vpc" "my_vpc"{
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "my_vpc"
    }
}

#Define private subnet
resource "aws_subnet" 
"private_subnet" {
    vpc_id = aws_vpc.my_vpc.vpc_id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"

    tags = {
        Name = "private_subnet"
    }
}


#Define routing table
resource "aws_route_table" 
"private_route_table" {
    vpc_id = aws_vpc.my_vpc.vpc_id

    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = "nat-0a34a8efd5e420945"
        }


    tags = {
        Name = "private_route_table"
    }
}


#Define Lambda function =
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

    filename = "${path.module}/lambda_function.zip"
    source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")
    }


    tags = {
        Name = "private_route_table"
    }
}


#Define Lambda IAM role
data "aws_iam_role" "lambda" {
    name = "DevOps-Candidate-Lambda-Role"
}



#Define security Group for Lambda function
resource "aws_security_group" 
"lambda_sg"{
    name = "lambda-sg"
    description = "Security group for Lambda function"
    vpc_id = aws_vpc.my_vpc.id

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

    tags = {
        Name = "lambda_sg"
    }
}



