terraform {
  backend "s3" {
    bucket         = "terraform-state-subodh-eu-west-1-856970428305"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-locks"
  }
}