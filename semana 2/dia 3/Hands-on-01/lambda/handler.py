import logging
from sqs import Sqs


LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)

def handler(event, context):
  message = event['body']
  LOGGER.info(message)
  reponse = Sqs().sendMensagem(message)
  return reponse