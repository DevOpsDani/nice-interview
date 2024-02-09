output "s3_tf_backend_bucket" {
  value = aws_s3_bucket.s3_tf_backend.bucket
}

# output "s3_tf_backend_bucket_arn" {
#   value = aws_s3_bucket.s3_tf_backend.arn
# }

output "s3_bucket_id" {
  value = aws_s3_bucket.s3_tf_backend.id
}