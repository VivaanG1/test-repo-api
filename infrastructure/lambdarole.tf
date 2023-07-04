resource "aws_iam_role" "lambda_iam_role" {
  name               = "${var.environment}-sdp-federated-id-key-gateway-role"
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
  name   = "${var.environment}-sdp-federated-id-key-gateway-policy"
  role   = aws_iam_role.lambda_iam_role.id
  policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Lambdaexternal",
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Resource": [
                "arn:aws:iam::977228593394:role/int-federated-id-secrets-LocalFederatedIdSecretsM-P9DKD89JWQNT"
            ]
        },
        {
            "Sid": "cloudwatchlogs",
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
                "${aws_cloudwatch_log_group.log_group.arn}:*"
            ]
        }
    ]
}
EOF
}