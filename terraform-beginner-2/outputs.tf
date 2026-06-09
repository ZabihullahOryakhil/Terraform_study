output "instance_id" {
  value = aws_instance.web.id
}

output "public_ip" {
  value = "http://${aws_instance.web.public_ip}"
}

output "public_dns" {
  value = aws_instance.web.public_dns
}

output "private_ip" {
  value = aws_instance.web.private_ip
  sensitive = true
}