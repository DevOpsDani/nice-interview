output "s3_tf_backend_bucket" {
  value       = module.s3.s3_tf_backend_bucket
  description = "S3 bucket to manage Terraform state file."
}


output "s3_bucket_id" {
  value = module.s3.s3_bucket_id
}

# output "s3_tf_backend_bucket_arn" {
#   value       = module.s3.s3_tf_backend_bucket_arn
#   description = "S3 bucket arn."
# }
