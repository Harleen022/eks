variable "instance_type" {
  description = "The instance type to use for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "The name to give to the EC2 instance"
  type        = string
}

variable "environment" {
  description = "The environment this instance belongs to"
  type        = string
  default     = "dev"
}

variable "subnet_id" {
  description = "The subnet ID where the instance will be launched"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = true
}

variable "root_volume_size" {
  description = "Size of the root volume in gigabytes"
  type        = number
  default     = 20
}

variable "key_name" {
  description = "Name of the SSH key pair to use for the instance"
  type        = string
} 