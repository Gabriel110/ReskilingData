import logging
from dynamo import Dynamo
import json

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)

def handler(event, context):
  body = json.loads(event['body'])
  LOGGER.info(body)
  dynamoJson = Dynamo.generareJson(body['name'],body['cpf'], body['birth'])
  Dynamo().putItem('PESSOA',dynamoJson)
  return event