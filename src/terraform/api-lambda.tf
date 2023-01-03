
resource "aws_lambda_function" "pooltourney-api" {
  filename      = "../artifacts/lambda_function_payload.zip"
  function_name = "pooltourney-api"
  role          = aws_iam_role.iam_for_pooltourney_api_lambda.arn
  handler       = "index.handler"

  source_code_hash = filebase64sha256( "../artifacts/lambda_function_payload.zip")

  runtime = "nodejs12.x"
}

resource "aws_iam_role" "iam_for_pooltourney_api_lambda" {
  name = "iam_for_pooltourney_api_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "pooltourney-lambda-dynamo-attachment" {
  name       = "pooltourney-lambda-dynamo-attachment"
  roles      = [aws_iam_role.iam_for_pooltourney_api_lambda.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_policy_attachment" "pooltourney-lambda-execution-attachment" {
  name       = "pooltourney-lambda-execution-attachment"
  roles      = [aws_iam_role.iam_for_pooltourney_api_lambda.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
