resource "aws_instance" "nginx-server" {
  ami = "ami-02d26659fd82cf299"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public-subnet.id
    vpc_security_group_ids = [aws_security_group.nginx-sg1.id]
    associate_public_ip_address =  true


    user_data = <<-EOF
                #!/bin/bash
                 sudo yum update -y
                 sudo yum install nginx -y
                  sudo systemctl start nginx
                 EOF

     tags = {
      Name = "nginx-server"
      }
}