import logging
import urllib

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)

def handler(event, context):
  LOGGER.info(event)
  return event