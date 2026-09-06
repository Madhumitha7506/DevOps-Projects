variable "environment" {
  type        = string
  description = "Deployment environment"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
  default     = ""
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for DB subnet group"
}

variable "db_username" {
  type        = string
  description = "Master username for database"
}

variable "db_password" {
  type        = string
  description = "Master password for database"
  sensitive   = true
}

variable "db_security_group_id" {
  type        = string
  description = "Security group ID for database"
  default     = ""
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs for database"
  default     = []
}

variable "db_name" {
  type        = string
  description = "Database name"
  default     = "javaapp"
}