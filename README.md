# NSQ SELF.DRIVEN

[NSQ](https://nsq.io/) Self.Driven is an entire ecosystem in containers with publisher, message platform and consumer.

Article [NSQ with Docker in baby steps, less then 70 lines of code](https://victoralmeidabarros.medium.com/nsq-with-docker-in-baby-steps-70-lines-of-code-381ac37eaf58)

## Usage

`Makefile`

```sh
make clean-up
# remove containers and images

make start
# start docker-compose project

make status
# check status

make log
# follow logs
```

<p align="center">
    <img src="./assets/logs.png" />
    <!-- Font: https://nsq.io/overview/design.html#simplifying-configuration-and-administration -->
  </a>
</p>

## License

[MIT](LICENCE)

<!-- 
TODO:
  - add code climate https://codeclimate.com/github/victorabarros/travel-routes-optimizer
-->