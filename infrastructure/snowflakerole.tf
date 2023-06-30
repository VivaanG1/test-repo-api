data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_iam_role" "snowflake_iam_role" {
  name        = "${var.environment}-sdp-federated-id-key-gateway-snowflake-role"
  description = "IAM role for snowflake"

  assume_role_policy = jsonencode({
	"Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Principal": {
				"AWS": "arn:aws:iam::672255977428:user/sil70000-s"
			},
			"Action": "sts:AssumeRole",
			"Condition": {
				"StringEquals": {
					"sts:ExternalId": "BBCSTUDIOS_SFCRole=12_RMYM4mN+ds2PFHGJ3+NlEX5x4K0="
				}
			}
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
          "${aws_apigatewayv2_stage.gateway_stage.execution_arn}/*"
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