echo " _ __   ___   __ _   "
echo "| '_ \ / __| / _' |  "
echo "| | | |\__ \| (_| |  "  # TODO: Continue
echo "|_| |_||___/ \__, |  "
echo "                |_|  "



echo && echo "Kill containers and images: "
docker rm -f nsq-service-self-driven_nsqadmin_1
docker rm -f nsq-service-self-driven_nsqd_1
docker rm -f nsq-service-self-driven_nsqlookupd_1
docker rm -f nsq-service-self-driven_writer_1
docker rm -f nsq-service-self-driven_pyreader_1
docker rm -f nsq-service-self-driven_goreader_1
# Images:
docker rmi -f nsqio/nsq:v1.2.0
docker rmi -f nsq-service-self-driven_writer
docker rmi -f nsq-service-self-driven_pyreader
docker rmi -f nsq-service-self-driven_goreader
docker rmi -f golang:1.14-alpine

echo && echo "compose up: "
docker-compose up -d  # -d to don't lock terminal with logs

echo && echo "compose ps: "
docker-compose ps

echo && echo "compose logs: "
docker-compose logs

echo && echo "lookup ping : "
curl http://127.0.0.1:4161/ping && echo

echo && echo "nsqd status: "
curl http://127.0.0.1:4151/stats

echo && echo "Publishing first message and create a topic: "
curl -d "First Message $(date +%T)" "localhost:4151/pub?topic=firsttopic"

echo && echo "Creating channels on nsqd: "
curl -X POST "http://127.0.0.1:4151/channel/create?topic=firsttopic&channel=pychann"
curl -X POST "http://127.0.0.1:4151/channel/create?topic=firsttopic&channel=gochann"

echo && echo "nsqadmin on: http://localhost:4171/topics/firsttopic"

echo && echo "goreader logs: docker logs -f nsq-service-self-driven_goreader_1"
echo "pyreader logs: docker logs -f nsq-service-self-driven_pyreader_1"

echo
