import boto3
import os
import uuid

sns_url = 'http://%s:4566' % os.environ['LOCALSTACK_HOSTNAME']
client = boto3.client('dynamodb', aws_access_key_id="test", aws_secret_access_key="test", region_name="us-east-1", endpoint_url=sns_url)


class Dynamo:
  
  def putItem(self, table, json):
    try:
      client.put_item(TableName=table, Item=json)
    except Exception as e:
      print(e)
      
  def generareJson(nome, cpf, nascimento):
    return {
      'PK': {'S':f'{uuid.uuid4()}'},
      'SK': {'S':f'{uuid.uuid4()}'},
      'nome': {'S':nome},
      'cpf': {'S':cpf},
      'nascimento': {'S':nascimento}
    }
  