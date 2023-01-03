

// Documentation:
// https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/dynamodb-example-document-client.html
// Sample event payload 
// {
//     requestContext: {
//       routeKey: '$default',
//       messageId: 'WhmgWfnVoAMCJIA=',
//       eventType: 'MESSAGE',
//       extendedRequestId: 'WhmgXFHcoAMFjqQ=',
//       requestTime: '08/Aug/2022:03:35:04 +0000',
//       messageDirection: 'IN',
//       stage: 'tennismatcher-stage',
//       connectedAt: 1659929226839,
//       requestTimeEpoch: 1659929704501,
//       identity: { sourceIp: '24.56.239.176' },
//       requestId: 'WhmgXFHcoAMFjqQ=',
//       domainName: '1dedyuuy4g.execute-api.us-east-1.amazonaws.com',
//       connectionId: 'WhlVudEwIAMCJIA=',
//       apiId: '1dedyuuy4g'
//     },
//     body: '{\n    "action": "getPlayer",\n    "userName": "bjohn454@gmail.com"\n}',
//     isBase64Encoded: false
//   }

const { routeRequest } = require("./router");

exports.handler = async (event, context) => {

    console.log(event);

    const ret = await routeRequest(event)

    return {
        "isBase64Encoded": false,
        "statusCode": 200,
        "headers": {},
        "body": JSON.stringify(ret)
    };
};