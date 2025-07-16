output "instance_id" {
  description = "The ID of the created EC2 instance"
  value       = aws_instance.ubuntu_server.id
}

output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.ubuntu_server.public_ip
}

output "private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.ubuntu_server.private_ip
} 