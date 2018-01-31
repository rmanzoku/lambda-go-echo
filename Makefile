.PHONY: setup build run

run: build
	aws-sam-local local invoke --event event.json

setup:
	go get -u github.com/awslabs/aws-sam-local

build:
	GOOS=linux go build -o main
