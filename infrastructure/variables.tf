variable "environment" {
  description = "Environment for Lambda function and API Gateway"
  type        = string
  default     = "jaishriram"
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
  default     = "arn:aws:iam::973456788012:role/int-federated-id-secrets-LocalFederatedIdSecretsM-P9DKD89JWQNT"
}

variable "account_id" {
  description = "AWS account id required by snowflake"
  type        = string
  default     = "442494022567"
}