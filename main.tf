resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
  }
}

resource "aws_security_group" "example" {
  name        = "example-security-group"
  description = "Example security group"
  vpc_id      = aws_vpc.example.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "example" {
  engine               = "mysql"
  identifier           = "example-rds-instance"
  allocated_storage    = 20
  instance_class       = "db.t2.micro"
  username             = "exampleuser"
  password             = "examplepassword"
  subnet_group_name    = "example-subnet-group"
  vpc_security_group_ids = ["sg-0123456789abcdef"]
  skip_final_snapshot  = true
}



resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = "example-key"
  security_groups = ["example-security-group"]
  user_data     = <<-EOF
                  #!/bin/bash
                  yum update -y
                  yum install -y httpd24 php56 mysql55-server php56-mysqlnd
                  service httpd start
                  chkconfig httpd on
                  groupadd www
                  usermod -a -G www ec2-user
                  chown -R root:www /var/www
                  chmod 2775 /var/www
                  find /var/www -type d -exec chmod 2775 {} +
                  find /var/www -type f -exec chmod 0664 {} +
                  echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php
                  EOF
}

resource "aws_alb" "example" {
  name            = "example-alb"
  internal        = false
  security_groups = [aws_security_group.alb.id]
  subnets         = aws_subnet.alb_subnets.*.id
  idle_timeout    = 60
  enable_deletion_protection = false
  tags = {
    Name = "example-alb"
  }
}

