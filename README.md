# NSQ SERVICE SELF.DRIVEN

[NSQ](https://nsq.io/) Self.Driven is an entire ecosystem in containers with publisher, message plataform and consumer.

```sh
>>> docker-compose ps
                Name                              Command               State                                                             Ports                                                           
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
nsq-service-self-driven_goreader_1     ./main                           Up                                                                                                                                
nsq-service-self-driven_nsqadmin_1     /nsqadmin --lookupd-http-a ...   Up      4150/tcp, 4151/tcp, 4160/tcp, 4161/tcp, 4170/tcp, 0.0.0.0:4171->4171/tcp,:::4171->4171/tcp                                
nsq-service-self-driven_nsqd_1         /nsqd --lookupd-tcp-addres ...   Up      0.0.0.0:4150->4150/tcp,:::4150->4150/tcp, 0.0.0.0:4151->4151/tcp,:::4151->4151/tcp, 4160/tcp, 4161/tcp, 4170/tcp, 4171/tcp
nsq-service-self-driven_nsqlookupd_1   /nsqlookupd                      Up      4150/tcp, 4151/tcp, 0.0.0.0:4160->4160/tcp,:::4160->4160/tcp, 0.0.0.0:4161->4161/tcp,:::4161->4161/tcp, 4170/tcp, 4171/tcp
nsq-service-self-driven_publisher_1    sh ./publish.sh                  Up                                                                                                                                
nsq-service-self-driven_pyreader_1     python3 reader.py                Up                                                                                                                                
```

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

## License

[MIT](LICENCE)
