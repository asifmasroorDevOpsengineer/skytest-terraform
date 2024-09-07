
variable "region" {
  type        = string
  default     = "us-east-1"
  description = "The AWS region to deploy the infrastructure to."
}

variable "instance_type" {
  type        = string
  description = "The type of EC2 instance to launch."
}

variable "web_server_count" {
  type        = number
  description = "The number of web-servers to launch."
  default     = 2
}

variable "http_port" {
  type        = number
  description = "The port on which the HTTP server listens."
  default     = 80
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC to deploy to."
  default     = "my_test_vpc"
}

variable "vpc_cidr_prefix" {
  type        = string
  description = "The CIDR block for the VPC."
  default     = "10.0"
}

variable "subnet_id" {
  default = ""
}

variable "weight_tg1" {
  default = 75
}

variable "weight_tg2" {
  default = 25
}