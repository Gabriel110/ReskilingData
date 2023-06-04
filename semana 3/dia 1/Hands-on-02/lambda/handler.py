import logging
import boto3

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)

rds_cliente = boto3.client('rds-data')

database_name = "gabrielpostgresqlv2"
db_clusrer_arn = "arn:aws:rds:us-east-1:797844572213:cluster:gabrielpostgresqlv2"
db_credentiais_secrets_store_arn = "arn:aws:secretsmanager:us-east-1:797844572213:secret:rds!cluster-78c9fd1c-dfe6-473b-9adc-145152be9cd0-1wjBCq"

def handler(event, context):
  try:
    LOGGER.info(event)
    response = execute_statement('SELECT * FROM gabrielpostgresqlv2.Customer')
  except Exception as e:
    raise print(e)
  
def execute_statement(sql):
  response = rds_cliente.execute_statement(
    secretArn=db_credentiais_secrets_store_arn,
    database=database_name,
    resourceArn=db_clusrer_arn,
    sql=sql
  )
  return response