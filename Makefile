NAME=rmanzokutest

export AWS_PROFILE=default
export AWS_DEFAULT_REGION=ap-northeast-1
S3_BUCKET=bucket
S3_PREFIX=github.com/rmanzoku/lambda-go-echo

.PHONY: setup run_local deploy

run_local: main
	aws-sam-local local invoke --event event.json

main: main.go
	GOOS=linux go build -o main

packaged.yml: main
	aws-sam-local package \
	--template-file template.yml \
	--s3-bucket $(S3_BUCKET) \
	--s3-prefix $(S3_PREFIX) \
	--output-template-file packaged.yml

deploy: packaged.yml
	aws-sam-local deploy --template-file packaged.yml --stack-name $(NAME) --capabilities CAPABILITY_IAM

setup:
	pip install -r requirements.txt
