import logging
from dynamo import Dynamo

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)

def handler(event, context):
  LOGGER.info(event)
  json = Dynamo.generareJson(event['name'],event['cpf'], event['birth'])
  Dynamo().putItem('PESSOA',json)
  return event