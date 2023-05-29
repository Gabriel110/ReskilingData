# ReskilingData
Formação Data Mesh proporcionada pela zup

## Comando terraform
- terraform init
- terraform plan
- terraform apply --auto-approve 
- terraform plan -destroy
- terraform apply -destroy --auto-approve 

## Ok
- http://localhost:4566/restapis/API_ID/dev/_user_request_/api

## Comando aws
  - aws apigateway get-api-keys --endpoint-url=http://localhost:4566 --region us-west-1
  - aws lambda --endpoint http://localhost:4566 get-function --function-name lambda-process
  - aws lambda invoke --function-name gabriel --endpoint-url=http://localhost:4566 --payload 'eyJxdWFudGl0eSI6IDJ9' output.txt
  - aws --endpoint-url=http://localhost:4566 lambda list-functions
  - aws --endpoint-url=http://localhost:4566 sns list-subscriptions
  - aws --endpoint-url=http://localhost:4566 sns publish --topic-arn arn:aws:sns:us-east-1:000000000000:sns-lambda --message '{"nascimento": "16-12-1996","cpf": "10777197014","nome":"gabriel"}'
  - aws --endpoint-url=http://localhost:4566 sqs list-queues
  - aws --endpoint-url=http://localhost:4566 sqs send-message --queue-url http://localhost:4566/000000000000/sqs-lambda --message-body {"nascimento": "16-12-1996","cpf": "10777197014","nome":"gabriel"}'
  - aws --endpoint-url=http://localhost:4566 sqs receive-message --queue-url http://localhost:4566/000000000000/sqs-lambda
