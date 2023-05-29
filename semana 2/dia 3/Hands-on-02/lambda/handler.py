import logging
from dynamo import Dynamo
import json

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)

def handler(event, context):
  for record in event['Records']:
    LOGGER.info(record['body'])
    body = json.loads(record['body'])
    LOGGER.info(body['nome'])
    dynamoJson = Dynamo.generareJson(body['nome'],body['cpf'], body['nascimento'])
    Dynamo().putItem('PESSOA',dynamoJson)
  return event