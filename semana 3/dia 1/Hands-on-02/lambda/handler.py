import logging
import boto3

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)

client = boto3.client('s3')    


def handler(event, context):
  try:
    LOGGER.info(event)
  except Exception as e:
    raise print(e)