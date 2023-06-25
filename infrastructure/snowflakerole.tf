data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_iam_role" "snowflake_iam_role" {
  name        = "${var.environment}-sdp-federated-id-key-gateway-snowflake-role"
  description = "IAM role for snowflake"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "AWS" : "856970428305"
        },
        "Condition" : {}
      }
    ]
  })
}

resource "aws_iam_policy" "snowflake_iam_policy" {
  name        = "${var.environment}-sdp-federated-id-key-gateway-snowflake-role"
  description = "Snowflake policy permission"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "execute-api:Invoke"
        ],
        "Resource" : [
          "arn:aws:execute-api:eu-west-1:${data.aws_caller_identity.current.account_id}:aws_apigatewayv2_api.gateway.id/*/*/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "snowflake_role_policy_attachment" {
  name       = "Policy Attachement"
  policy_arn = aws_iam_policy.snowflake_iam_policy.arn
  roles      = [aws_iam_role.snowflake_iam_role.name]
}