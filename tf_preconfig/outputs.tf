output "s3_tf_backend_bucket" {
  value       = module.s3.s3_tf_backend_bucket
  description = "S3 bucket to manage Terraform state file."
}
