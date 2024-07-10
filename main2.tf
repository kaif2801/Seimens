provider "aws" {
    region = "ap-south-1"
}


terraform{
    backend "s3"
    {
        bucket = "467.devops.candidate.exam"
        Region: "ap-south-1"
        Key: "KaifRaza.Shaikh"
    }
}

resource "aws_subnet" "private" {
    vpc_id = data.aws_vpc.vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"

    tags = {
        Name = "private_subnet"
    }
}

resource "aws_route_table" "private" {
    vpc_id = data.aws_vpc.vpc.id

    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = data.aws_nat_gateway.nat.id
        }


    tags = {
        Name = "private_route_table"
    }
}

resource "aws_route_table_association" "private" {
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.private.id
}

resource "aws_security_group" 
"lambda_sg"{
    name_prefix = "lambda_sg"
    vpc_id = data.aws_vpc.vpc.id

     ingress {
        from_port = 80
        to_port = 80
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

resource "aws_lambda_function" "lambda" {
    filename = "lambda_function2.zip"
    
    
    function_name = "devops_lambda"
    
    role = data.aws_iam_role.lambda.arn
    handler = "lambda_function.lambda_handler"
    runtime = "python3.8"
    timeout = 60
    

    vpc_config{
    subnet_ids = [aws_subnet.private_subnet.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
       }

    tags = {
        Name = "private_route_table"
    }
}




data "aws_vpc" "vpc"{
    id = "vpc-06b326e20d7db55f9"
}

data "aws_nat_gateway" "vpc"{
    id = "nat-0a34a8efd5e420945"
}

data "aws_iam_role" "lambda" {
    name = "DevOps-Candidate-Lambda-Role"
}














   