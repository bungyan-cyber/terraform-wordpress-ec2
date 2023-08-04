# Outputs
output "wordpress_public_ip" {
  description = "Public IP address of the WordPress instance"
  value       = aws_instance.wordpress_instance.public_ip
}

output "wordpress_instance_id" {
  description = "ID of the provisioned WordPress instance"
  value       = aws_instance.wordpress_instance.id
}
