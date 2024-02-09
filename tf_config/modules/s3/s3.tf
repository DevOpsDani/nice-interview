resource "aws_s3_bucket" "s3_tf_backend" {
  bucket = "daniel-interview-nice-devops-interview-bucket"
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

resource "aws_s3_bucket_notification" "bucket_terraform_notification" {
   bucket = aws_s3_bucket.s3_tf_backend.id
   lambda_function {
       lambda_function_arn = var.lambda_arn
       events = ["s3:ObjectCreated:*"]
   }
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.s3_tf_backend.arn
}


