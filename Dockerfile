FROM golang:1.10-alpine AS build
RUN apk add --no-cache git build-base
RUN mkdir /go/src/get-ssm
ADD main.go /go/src/get-ssm
RUN cd /go/src/get-ssm && go get && go build

FROM quay.io/coreos/clair:v2.0.9
COPY --from=build /go/src/get-ssm/get-ssm /get-ssm
ADD run.sh /run.sh
RUN chmod +x /run.sh

ENV LOG_LEVEL=info
ENTRYPOINT ["/run.sh"]

