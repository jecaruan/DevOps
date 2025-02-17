terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.84.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-southeast-1"
}

resource "aws_instance" "ubuntu" { # EC2
    ami = "ami-0198a868663199764" # Ubuntu 22.04 ap-southeast-1 https://cloud-images.ubuntu.com/locator/ec2/ 
    instance_type = "t2.micro" # https://aws.amazon.com/ec2/instance-types/
    tags = {
        Name = "Web Service"
    }

    user_data = <<-EOF
        #!/bin/bash
          
          sudo apt update -y
          sudo apt install apache2 -y
          sudo apt install net-tools -y
          sudo ufw status -y
          sudo ufw app list -y
          sudo ufw allow in "Apache" -y
          sudo ufw allow in "OpenSSH" -y
          sudo ufw enable -y
          sudo ufw status -y
          
        EOF
}

