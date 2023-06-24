resource "aws_apigatewayv2_api" "gateway" {
  depends_on    = [aws_lambda_function.lambda]
  name          = "${var.environment}-sdp-federated-id-key-gateway"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "api_integration" {
  api_id           = aws_apigatewayv2_api.gateway.id
  integration_type = "AWS_PROXY"

  connection_type      = "INTERNET"
  integration_method   = "POST"
  integration_uri      = aws_lambda_function.lambda.invoke_arn
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_authorizer" "gateway_authorizer" {
  depends_on                        = [aws_apigatewayv2_api.gateway, aws_iam_role.snowflake_iam_role]
  api_id                            = aws_apigatewayv2_api.gateway.id
  authorizer_type                   = "REQUEST"
  authorizer_uri                    = aws_lambda_function.lambda.invoke_arn
  authorizer_credentials_arn        = aws_iam_role.snowflake_iam_role.arn
  authorizer_result_ttl_in_seconds  = "0"
  identity_sources                  = ["$request.header.Authorization"]
  name                              = "${var.environment}-sdp-federated-id-key-gateway-authorizer"
  authorizer_payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "gateway_route" {
  api_id        = aws_apigatewayv2_api.gateway.id
  route_key     = "$default"
  authorizer_id = aws_apigatewayv2_authorizer.gateway_authorizer.id

}

resource "aws_apigatewayv2_deployment" "gateway_deploy" {
  api_id      = aws_apigatewayv2_api.gateway.id
  description = "${var.environment}-sdp-federated-id-key-gateway"

  triggers = {
    redeployment = sha1(join(",", list(
      jsonencode(aws_apigatewayv2_integration.api_integration),
      jsonencode(aws_apigatewayv2_route.gateway_route),
    )))
  }

  lifecycle {
    create_before_destroy = true
  }
}