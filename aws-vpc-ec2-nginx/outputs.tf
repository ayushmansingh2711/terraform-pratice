output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.nginx-server.public_ip
  
}

output "instance_url" {
  value = "http://${aws_instance.nginx-server.public_ip}"
    description = "URL to access the NGINX server"
}