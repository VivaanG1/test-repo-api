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
        "Resource": "arn:aws:iam::123456789098:role/int-iyutruyrttrtrryyruruyruyrfgxfgxgr"
    }
}
  EOF
}