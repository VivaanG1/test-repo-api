resource "aws_iam_role" "snowflake_iam_role" {
  name        = "${var.environment}-sdp-federated-id-key-gateway-snowflake-role"
  description = "IAM role for snowflake"

  # assume_role_policy = jsonencode(
  #   {
  #     "Version" : "2012-10-17",
  #     "Statement" : [
  #       {
  #         "Sid" : "Statement1",
  #         "Effect" : "Allow",
  #         "Principal" : {
  #           "AWS" : "arn:aws:iam::123456789012:role/snowflake-to-share"
  #         },
  #         "Action" : "sts:AssumeRole"
  #       }
  #     ]
  # })
}

resource "aws_iam_policy" "snowflake_iam_policy" {
  name        = "${var.environment}-sdp-federated-id-key-gateway-snowflake-role"
  description = "Snowflake policy permission"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:sts::${var.account_id}:assumed-role/<${aws_iam_role.snowflake_iam_role.name}/snowflake"
        },
        "Action" : "execute-api:Invoke",
        "Resource" : "${aws_apigatewayv2_api.gateway.execution_arn}"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "snowflake_role_policy_attachment" {
  name       = "Policy Attachement"
  policy_arn = aws_iam_policy.snowflake_iam_policy.arn
  roles      = [aws_iam_role.snowflake_iam_role.name]
}