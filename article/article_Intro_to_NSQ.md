# Introduction to NSQ with Docker

## Disclaimer

In the last year, one of the most popular buzzword in the technology scenarios was **event**: Event sourcing pattern, event-driven programming, domain event pattern, even-driven architecture …

So, this is not an article about event, but about **NSQ**, probably the simplest tool that can make your system event-friendly.

[_NSQ is a realtime distributed messaging platform_](https://nsq.io/) ready to run in super easies steps. But, to make this case even more professional, let's use [Docker](https://www.docker.com/)!

In the following steps, I'll describe a tutorial to make your system up and running with NSQ, publisher and consumer (in Go and Python). All them containerized.

## NSQ

Here I'll not going deep on NSQ anatomy, the official web site has a excelent [_documentation_](https://nsq.io/) about this.

But to begin, it's important to know the basics about how the event drives inside the system.
So before start read this chapter from official documentation to be ensurence about the nexts steps.

[Simplifying Configuration and Administration](https://nsq.io/overview/design.html#simplifying-configuration-and-administration)

[.gif]

## Pre requirements

- [Docker](https://docs.docker.com/engine/install/)
- [Docker-Compose](https://docs.docker.com/compose/install/)

## docker-compose.yml

To setup a docker-compose.yml with the NSQ services is extremimly simple, the documentations already made this for us.
[docker-compose.yml NSQ services](https://nsq.io/deployment/docker.html#using-docker-compose).
And now already is possible to watch the nsqadmin on port `4171`.

With admin service you can watch the topics, channels and queue counters.

## References

https://youtu.be/CL_SUzXIUuI
https://nsq.io/overview/design.html
