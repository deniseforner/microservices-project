resource "aws_s3_bucket" "test" {
  bucket = "test-bucket-${random_id.suffix.dec}"
}

resource "random_id" "suffix" {
  byte_length = 4
}