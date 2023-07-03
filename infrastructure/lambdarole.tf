resource "aws_iam_role" "lambda_iam_role" {
  name = "${var.environment}-sdp-federated-id-key-gateway-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "lambda.amazonaws.com"
                ]
            }
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_iam_policy" {
  name = "${var.environment}-sdp-federated-id-key-gateway-policy"
  role = aws_iam_role.lambda_iam_role.id

  policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": {
        "Effect": "Allow",
        "Action": "sts:AssumeRole",
        "Resource": "arn:aws:iam::977678965431:role/int-federated-id-secrets-LocalFederatedIdSecretsM-P9DKD89JWQNT"
    }
}
  EOF
}

resource "aws_iam_role_policy" "lambda_iam_policy2" {
  name = "${var.environment}-sdp-federated-id-key-gateway-policy2"
  role = aws_iam_role.lambda_iam_role.id

  policy = <<-EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "Statement1",
			"Effect": "Allow",
			"Action": [
				"logs:CreateLogStream",
				"logs:CreateLogGroup",
				"logs:DescribeLogGroups",
				"logs:DescribeLogStreams",
				"logs:GetLogEvents",
				"logs:PutLogEvents",
				"logs:PutRetentionPolicy"
			],
			"Resource": [
				"*"
			]
		}
	]
}
  EOF
}