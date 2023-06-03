import logging
import boto3

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)

nome_do_s3 = "gabriel-bucket-122345"
client = boto3.client('s3')    


def handler(event, context):
  try:
    bucket = event['Records'][0]['s3']['bucket']['name']
    key    = event['Records'][0]['s3']['object']['key']
    client.upload_file("hello-s3.txt", nome_do_s3, "hello-s3")
    response = client.get_object(Bucket=bucket, Key=key)
    data = response['Body'].read().decode('utf-8')
    LOGGER.info(data)
  except Exception as e:
    raise print(e)