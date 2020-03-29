// from https://godoc.org/github.com/nsqio/go-nsq
package main

import (
    "fmt"
    "github.com/nsqio/go-nsq"
)

type myMessageHandler struct {}

func (h *myMessageHandler) HandleMessage(m *nsq.Message) error {
    if len(m.Body) == 0 {
        return nil
    }

    fmt.Println(m.Body)
    return nil
}

func main() {
    config := nsq.NewConfig()
    topic := "firsttopic"
    channel := "gochann"
    lookup_url := "nsqlookupd:4161"

    consumer, err := nsq.NewConsumer(topic, channel, config)
    if err != nil {
        fmt.Println(err)
    }

    consumer.AddHandler(&myMessageHandler{})
    err = consumer.ConnectToNSQLookupd(lookup_url)

    if err != nil {
        fmt.Println(err)
    }

    // consumer.Stop()
}
