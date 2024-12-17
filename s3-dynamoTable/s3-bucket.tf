# Create an S3 Bucket
resource "aws_s3_bucket" "mybucket" {
  bucket = "susans3bucket980807"

  # Add tags to the S3 bucket
  tags = {
    Name        = "MyS3Bucket"
    Environment = "Dev"
  }
}

# Enable versioning on the S3 bucket
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.mybucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable Server-Side Encryption (SSE) with the AES-256 algorithm
resource "aws_s3_bucket_server_side_encryption_configuration" "encrypts3" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

# Create DynamoDB table
resource "aws_dynamodb_table" "statelock" {
  name = "state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}