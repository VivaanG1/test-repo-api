variable "environment" {
  description = "Environment for Lambda function and API Gateway"
  type        = string
  default     = "subodhk"
}
variable "federated_id_env" {
  description = "Environment variable for FedID environment"
  type        = string
  default     = "int"
}

variable "secret_manager_region" {
  description = "Environment variable for FedID secret manager"
  type        = string
  default     = "eu-west-1"
}

variable "secret_manager_role" {
  description = "Environment variable for FedID secret manager role"
  type        = string
  default     = "arn:aws:iam::123456789098:role/restofone"
}

variable "account_id" {
  description = "AWS account id required by snowflake"
  type        = string
  default     = "123456789098"
}