# This step will build the Bucket that will host both nessecery files and the tfstate backend file

resource "aws_s3_bucket" "s3_tf_backend" {
  bucket = "daniel-interview-s3-nice-tf-backend"
}

resource "aws_s3_bucket_public_access_block" "s3_public_block" {
  bucket                  = aws_s3_bucket.s3_tf_backend.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
  bucket = aws_s3_bucket.s3_tf_backend.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_object" "parse_me" {
  bucket = aws_s3_bucket.s3_tf_backend.bucket
  key    = "parse_me.txt"
  acl    = "private"  
  source = "parse_me.txt"
}
