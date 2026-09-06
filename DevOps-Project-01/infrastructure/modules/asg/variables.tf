variable "environment" {
  type        = string
  description = "Deployment environment"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for the Auto Scaling Group"
  default     = []
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private Subnet IDs for the Auto Scaling Group"
  default     = []
}

variable "target_group_arns" {
  type        = list(string)
  description = "Target Group ARNs for the ASG"
  default     = []
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security Group IDs for application instances"
  default     = []
}

variable "key_name" {
  type        = string
  description = "SSH key pair name"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
  default     = "t2.micro"
}

variable "min_size" {
  type        = number
  description = "Minimum size of ASG"
  default     = 2
}

variable "max_size" {
  type        = number
  description = "Maximum size of ASG"
  default     = 5
}

variable "desired_capacity" {
  type        = number
  description = "Desired capacity of ASG"
  default     = 2
}