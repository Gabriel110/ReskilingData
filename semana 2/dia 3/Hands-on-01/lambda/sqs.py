from boto3 import client
import json
import os

sqs_url = 'http://%s:4566' % os.environ['LOCALSTACK_HOSTNAME']
sqs = client('sqs', aws_access_key_id="test", aws_secret_access_key="test", region_name="us-east-1", endpoint_url=sqs_url)

class Sqs:
  
  def sendMensagem(self, message):
    try:
      response = sqs.send_message(
        QueueUrl="http://localhost:4566/000000000000/sqs-lambda",
        MessageBody=message
      )
      print('Message published to SQS')
      return {
        'statusCode': 200,
        'body': json.dumps(response)
      }
    except Exception as e:
      print('Failed to publish message to SQS')
      return {'status': 'error', 'message': e}