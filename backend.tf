terraform {
  backend "s3" {
    bucket = "susans3bucket980807"
    key    = "state"
    region = "us-east-1"
    dynamodb_table = "state-lock"
  }
}



