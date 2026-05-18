terraform {
  backend "s3" {
    bucket = "ecolibrium-terraform-state-srijanani"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}