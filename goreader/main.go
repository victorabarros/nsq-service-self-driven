// Based on https://godoc.org/github.com/nsqio/go-nsq
package main

import (
    "fmt"
    "os/signal"
    "syscall"
    "os"
    "github.com/nsqio/go-nsq"
)

type myMessageHandler struct {}

func (h *myMessageHandler) HandleMessage(m *nsq.Message) error {
    if len(m.Body) == 0 {
        return nil
    }

    fmt.Println(string(m.Body))  // TODO: Adicionar utcnow à mensagem e observar delay.
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

    shutdown := make(chan os.Signal, 2)
    signal.Notify(shutdown, syscall.SIGINT)

    for {
        select {
        case <-consumer.StopChan:
            return
        case <-shutdown:
            consumer.Stop()
        }
    }
}
