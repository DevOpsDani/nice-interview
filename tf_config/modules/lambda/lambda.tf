resource "aws_lambda_function" "lambda" {
  function_name    = "daniel-interview-nice-devops-interview-lambda"
  handler          = "index.handler"
  runtime          = "python3.9"
  filename         = "lambda_function.zip"
  role             = "arn:aws:iam::557414474363:role/daniel-interview-lambda-execution-role"
}


