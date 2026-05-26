resource "aws_s3_bucket" "example" {
  bucket = "my-tf-bucket-${random_id.suffix.dec}"
}

resource "random_id" "suffix" {
  byte_length = 4
}