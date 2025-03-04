variable "aws_integration_id" {
  type        = string
  description = "The AWS Ingegration to use for child stacks."
  default     = "01JAZPBRW3K2YB0K7F58NZSDY6"
}

variable "resource_space_id" {
  type        = string
  description = "The Space ID to use for created resources."
  default     = "root"
}

variable "ansible_worker_pool_id" {
  type        = string
  description = "The worker pool ID to use for ansible jobs."
  default     = "01JCZY4WD38EJS5S94B64E0V1Z"
}

variable "subnet_id" {
  type        = string
  description = "The subnet to launch instance in in the OpenTofu stack."
  default     = "subnet-03bf64b24af404d2a"
}

variable "vpc_security_group_id" {
  type        = string
  description = "The security group attached to instance in the OpenTofu stack."
  default     = "sg-01cb7dc1977bf9603"
}

variable "aws_default_region" {
  type        = string
  description = "The default region to use for the AWS provider."
  default     = "us-east-1"
}