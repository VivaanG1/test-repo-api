resource "aws_apigatewayv2_api" "gateway" {
  depends_on    = [aws_lambda_function.lambda]
  name          = "${var.environment}-sdp-federated-id-key-gateway"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "gateway_integration" {
  api_id                 = aws_apigatewayv2_api.gateway.id
  integration_type       = "AWS_PROXY"
  connection_type        = "INTERNET"
  integration_method     = "POST"
  integration_uri        = aws_lambda_function.lambda.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "gateway_route" {
  api_id             = aws_apigatewayv2_api.gateway.id
  route_key          = "ANY /{proxy+}"
  operation_name     = "${var.environment}-sdp-federated-id-key-gateway-operation"
  target             = "integrations/${aws_apigatewayv2_integration.gateway_integration.id}"
  authorization_type = "AWS_IAM"
}

resource "aws_apigatewayv2_deployment" "gateway_deploy" {
  api_id      = aws_apigatewayv2_api.gateway.id
  description = "${var.environment}-sdp-federated-id-key-gateway"
  depends_on  = [aws_apigatewayv2_route.gateway_route]
}

resource "aws_apigatewayv2_stage" "gateway_stage" {
  api_id = aws_apigatewayv2_api.gateway.id
  name   = var.environment
  # deployment_id = aws_apigatewayv2_deployment.gateway_deploy.id
  auto_deploy = true
}