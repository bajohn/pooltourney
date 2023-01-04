resource "aws_apigatewayv2_api" "pooltourney-api" {
  name                       = "pooltourney"
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"
  description                = "pooltourney Websocket API. Pull 'action' out of request JSON body."
}

resource "aws_iam_role" "iam_for_pooltourney_apigw" {
  name = "iam_for_pooltourney_apigw"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "pooltourney-apigw-attachment" {
  name       = "pooltourney-apigw-attachment"
  roles      = [aws_iam_role.iam_for_pooltourney_apigw.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaRole"
  #policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}

resource "aws_apigatewayv2_deployment" "pooltourney-deployment" {
  api_id      = aws_apigatewayv2_api.pooltourney-api.id
  description = "Pool tourney deployment"
  triggers = {
    redeployment = timestamp()
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_apigatewayv2_stage" "pooltourney-stage" {
  api_id = aws_apigatewayv2_api.pooltourney-api.id
  name   = "pooltourney-stage"
  default_route_settings {
    logging_level="INFO"
    throttling_rate_limit=1000
    throttling_burst_limit = 5000
  }
}

resource "aws_apigatewayv2_route" "default-route" {
  api_id    = aws_apigatewayv2_api.pooltourney-api.id
  route_key = "$default"
  target = "integrations/${aws_apigatewayv2_integration.default-integration.id}"
}

resource "aws_apigatewayv2_route_response" "default-route-response" {
  api_id    = aws_apigatewayv2_api.pooltourney-api.id
  route_id = aws_apigatewayv2_route.default-route.id
  route_response_key = "$default"
}

resource "aws_apigatewayv2_integration" "default-integration" {
  api_id           = aws_apigatewayv2_api.pooltourney-api.id
  integration_type = "AWS"

  content_handling_strategy = "CONVERT_TO_TEXT"
  description               = "Default Lambda Integration"
  integration_method        = "POST"
  integration_uri           = aws_lambda_function.pooltourney-api.invoke_arn
  credentials_arn           = aws_iam_role.iam_for_pooltourney_apigw.arn
  # integration_type           = "AWS_PROXY"
  # passthrough_behavior      = "WHEN_NO_MATCH"
}