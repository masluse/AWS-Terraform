output "info" {
  value = aws_ebs_volume.default
}

output "attachment" {
  value = aws_volume_attachment.default
}