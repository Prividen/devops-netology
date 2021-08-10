output "account_id" {
  description = "AWS account ID"
  value = data.aws_caller_identity.current.account_id
}

output "caller_user" {
  description = "Current user ID"
  value = data.aws_caller_identity.current.user_id
}

output "aws_region" {
  description = "Current AWS region"
  value = data.aws_region.current.name
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value = module.ec2-instance.private_ip
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value = module.ec2-instance.public_ip
}

output "instance_subnet_id" {
  description = "Subnet ID of the EC2 instance"
  value = module.ec2-instance.subnet_id
}

