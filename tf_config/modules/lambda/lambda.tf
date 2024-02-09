data "terraform_remote_state" "preconfig" {
  backend = "local"

  config = {
    path = "../tf_preconfig/terraform.tfstate"
  }
}

resource "aws_lambda_function" "lambda" {
  function_name    = "daniel-interview-lambda"
  handler          = "index.handler"
  runtime          = "python3.9"
  filename         = "lambda_function.zip"
  role             = "arn:aws:iam::557414474363:role/daniel-interview-lambda-execution-role"
}

resource "aws_s3_bucket_notification" "bucket_terraform_notification" {
   bucket = data.terraform_remote_state.preconfig.outputs.s3_bucket_id
   lambda_function {
       lambda_function_arn = aws_lambda_function.lambda.arn
       events = ["s3:ObjectCreated:*"]
   }
}

# resource "aws_lambda_event_source_mapping" "s3_trigger" {
#   event_source_arn = data.terraform_remote_state.preconfig.outputs.s3_tf_backend_bucket_arn
#   function_name    = aws_lambda_function.lambda.arn
#   batch_size       = 1
#   event            = "s3:ObjectCreated:*"
# }

