package main

import (
	"context"
	"log"
	"os"

	"github.com/aws/aws-lambda-go/lambda"
)

// Event from event.json
type Event map[string]interface{}

// HandleRequest is main handler
func HandleRequest(ctx context.Context, event Event) (string, error) {
	log.Print("value1 = ", event["key1"])
	log.Print("ENV", os.Getenv("HOGEHOGE"))
	return "ok", nil
}

func main() {
	lambda.Start(HandleRequest)
}
