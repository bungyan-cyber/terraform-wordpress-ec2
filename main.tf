provider "aws" {
  region = "ap-southeast-1"  # Change to your desired region
}

resource "aws_instance" "wordpress_instance" {
  ami           = "ami-002843b0a9e09324a"  # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
  instance_type = "t2.micro"
  subnet_id     = "subnet-027e97b03510547df"  # Replace with your subnet ID
  key_name      = "bungyan"  # Replace with your key pair name

  user_data = file("${path.module}/setup_wordpress.sh")

  tags = {
    Name = "wordpress-instance"
  }

  # Security Group Configuration
  vpc_security_group_ids = ["sg-0574f8cc70ca0126d"]  # Replace with your security group ID
}

