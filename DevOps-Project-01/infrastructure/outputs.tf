output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnet_ids
}

output "bastion_public_ip" {
  description = "Public IP address of the Bastion instance"
  value       = aws_instance.bastion.public_ip
}
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "rds_address" {
  value = module.rds.db_instance_address
}

output "asg_name" {
  value = module.asg.asg_name
}
