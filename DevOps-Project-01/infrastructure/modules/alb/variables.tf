variable "environment" {
  type        = string
  description = "Deployment environment"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "security_groups" {
  type        = list(string)
  description = "List of security group IDs for the ALB"
  default     = []
}

variable "subnets" {
  type        = list(string)
  description = "List of public subnet IDs for the ALB"
  default     = []
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnet IDs for the ALB"
  default     = []
}