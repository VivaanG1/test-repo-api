resource "aws_lambda_function" "lambda" {

  function_name = "${var.environment}-sdp-federated-id-key-gateway-lambda"
  description   = "Lambda function for FedID"
  filename      = "../build1.zip"
  handler       = "index.lambda_handler"
  role          = aws_iam_role.lambda_iam_role.arn
  runtime       = "nodejs18.x"
  memory_size   = "1024"

  environment {
    variables = {
      FEDERATED_ID_ENV       = "${var.federated_id_env}"
      SECRETS_MANAGER_REGION = "${var.secret_manager_region}"
      SECRETS_MANAGER_ROLE   = "${var.secret_manager_role}"
    }
  }
}

resource "aws_lambda_permission" "api_integration" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_stage.gateway_stage.execution_arn}/*/*"
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
  retention_in_days = 30
}