# TODO: alpine or slim, whos better?
FROM golang:1.14-alpine

COPY . .

RUN apk add git
RUN go get -d -v github.com/nsqio/go-nsq
RUN go build main.go

CMD ["./main"]
