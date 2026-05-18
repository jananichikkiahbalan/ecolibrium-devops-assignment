variable "aws_region" {
  description = "AWS region for infrastructure"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "ecolibrium"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}