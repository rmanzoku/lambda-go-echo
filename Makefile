PKG=github.com/rmanzoku/lambda-go-echo
NAME=lambda-go-echo

export AWS_PROFILE=default
export AWS_DEFAULT_REGION=ap-northeast-1
S3_BUCKET=build.prod.mch.djty.co

.PHONY: setup run_local deploy

run_local: $(NAME)
	sam local invoke --skip-pull-image --event event.json

$(NAME): main.go
	GOOS=linux GOARCH=amd64 go build -o $(NAME)

packaged.yml: template.yml $(NAME)
	sam package \
	--template-file template.yml \
	--s3-bucket $(S3_BUCKET) \
	--s3-prefix $(PKG) \
	--output-template-file packaged.yml

deploy: packaged.yml
	sam deploy --template-file packaged.yml --stack-name $(NAME) --capabilities CAPABILITY_IAM

setup:
	pip install -r requirements.txt
	docker pull lambci/lambda:go1.x
