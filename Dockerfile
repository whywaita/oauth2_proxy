FROM golang:latest as builder
RUN go get github.com/bitly/oauth2_proxy
WORKDIR /go/src/github.com/bitly/oauth2_proxy
RUN CGO_ENABLED=0 GOOS=linux go build -o oauth2_proxy .

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/bitly/oauth2_proxy/oauth2_proxy /oauth2_proxy
ENTRYPOINT ["/oauth2_proxy"]
