# Pool Tournament generator

WIP?

TODO: These need to be updated to Terraform 

- Role: iam_for_tennismatcher_apigw- Manually added AWSLambdaRole
- Lambda: pooltourney-api- Lambda Resource-based policy statements:
    - 3f6b6ce2-a2c9-4529-bbe4-689870ba6cb6	apigateway.amazonaws.com	-	ArnLike	lambda:InvokeFunction
- Lambda: pooltourney-api- seems to have dynamo permissions, which it does not need
