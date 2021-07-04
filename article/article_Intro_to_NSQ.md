# Introduction to NSQ with Docker

## Intro

In the last year, one of the most popular buzzword in the technology scenarios was **event**: Event sourcing pattern, event-driven programming, domain event pattern, event-driven architecture …

So, this is not an article about event, but about **NSQ**, probably the simplest tool that can make your system event-friendly.

[_NSQ is a realtime distributed messaging platform_](https://nsq.io/) ready to run in super easies steps. But, to make this case even more professional, let's use [Docker](https://www.docker.com/)!

In the following steps, I'll describe a tutorial to make your system up and running with NSQ, publisher and consumer in Python. All them containerized.

## NSQ

Here I'll not go deep on NSQ anatomy, the official website has excelent [_documentation_](https://nsq.io/) about this.

But to begin, it's important to know the basics about how the event drives inside the system.
So before start read this chapter from official documentation to be ensurence about the next steps.

[Internals](https://nsq.io/overview/internals.html#internals)

[.gif]

## Pre requirements

- [Docker](https://docs.docker.com/engine/install/)
- [Docker-Compose](https://docs.docker.com/compose/install/)

## NSQ setup

To setup a docker-compose.yml with the NSQ services is extremely simple, the documentations already made this for us.
Don't forget to mirror the nsqd and nsqadmin ports to use localhost.
[docker-compose.yml NSQ services](https://nsq.io/deployment/docker.html#using-docker-compose).

And now already is possible to watch the nsqadmin on `http://localhost:4171/`.

With the admin service you can watch the topics, channels and queue counters.

[screenshot]

To send your first message, the nsqd server exposes an endpoint to receive events. In the following example, I'm sending an empty payload to the `hello_world` topic, that doesn't exist yet, but the nsqd server will automatically create.

`curl -d "{}" http://localhost:4151/pub?topic=hello_world`

And here you can see all services endpoints that allow you to manage the topics and channels:

**[nsqd http api](https://nsq.io/components/nsqd.html#http-api)**
**[nsqlookupd http interface](https://nsq.io/components/nsqlookupd.html#http-interface)**

## Publisher

As we already saw, with a simple `curl` command is possible to publish messages.
So let's code a script that iterates and execute curl command:

```sh
while true
do
    curl -d "{\"foo\":\"bar\"}" "nsqd:4151/pub?topic=hello_world"
    sleep 2
done
```

Now `Dockerfile`:

```Dockerfile
FROM alpine

COPY ./publish.sh ./publish.sh
RUN apk add --no-cache curl

ENTRYPOINT ["sh", "./publish.sh"]
```

And add the new service to .yml file

```yml
  publisher:
    build: ./publisher/.
    depends_on:
      - nsqlookupd
```

## References

https://youtu.be/CL_SUzXIUuI
https://nsq.io/overview/design.html
