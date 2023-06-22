terraform {
  backend "s3" {
    bucket = "sdp-dev-mwaa-256073515130"
    key    = "terraform.tfstate"
    region = "eu-west-1"
    #dynamodb_table = "bbc-sdp-terraform-state-locks"
  }
}