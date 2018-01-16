

build:
	GOOS=linux go build -o main
	zip deployment.zip main

deploy:
	aws lambda create-function \
	--region us-west-1 \
	--function-name HelloFunction \
	--zip-file fileb://./deployment.zip \
	--runtime go1.x \
	--role arn:aws:iam::482902743189:role/lambda_basic_execution \
	--handler main