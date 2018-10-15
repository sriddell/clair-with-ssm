// Based on implementation by Binx.io B.V. at https://github.com/binxio/ssm-get-parameter
// Modified for custom use in clair container and to use AWS_DEFAULT_REGION by default.
package main

import (
	"flag"
	"fmt"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/ssm"
	"os"
)

func main() {
	withDecryption := true
	name := flag.String("parameter-name", "", "the name of the parameter")
	flag.Parse()

	if *name == "" {
		fmt.Fprintf(os.Stderr, "ERROR: missing option --parameter-name\n")
		os.Exit(1)
	}
	config := aws.NewConfig()
	if os.Getenv("AWS_DEFAULT_REGION") != "" {
		config = config.WithRegion(os.Getenv("AWS_DEFAULT_REGION"))
	}
	session, err := session.NewSession(config)
	if err != nil {
		fmt.Fprintf(os.Stderr, "ERROR: failed to create new session %s\n", err)
		os.Exit(1)
	}

	service := ssm.New(session)
	request := ssm.GetParameterInput{Name: name, WithDecryption: &withDecryption}
	response, err := service.GetParameter(&request)
	if err != nil {
		fmt.Fprintf(os.Stderr, "ERROR: failed to get parameter, %s\n", err)
		os.Exit(1)
	}

	fmt.Printf("%s", *response.Parameter.Value)
}
