go get -d -v github.com/nsqio/go-nsq && \
    apt update && apt install -y vim curl && \
    curl http://nsqlookupd:4161/lookup?topic=firsttopic && \
    touch main.go
vim main.go
go run main.go
