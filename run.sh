echo " _ __   ___   __ _   "
echo "| '_ \ / __| / _' |  "
echo "| | | |\__ \| (_| |  "  # TODO: Continue
echo "|_| |_||___/ \__, |  "
echo "                |_|  "



echo && echo "Kill containers and images: "
docker rm -f nsq_nsqadmin_1
docker rm -f nsq_nsqd_1
docker rm -f nsq_nsqlookupd_1
docker rm -f nsq_nsqwriter_1
docker rm -f nsq_nsqreader_1
# images:
docker rmi -f nsqio/nsq:v1.2.0
# docker rmi -f nsq_nsqwriter
# docker rmi -f golang:1.14

echo && echo "Compose up: "
docker-compose up -d  # -d to don't lock terminal with logs

echo && echo "Compose ps: "
docker-compose ps

echo && echo "Compose logs: "
docker-compose logs

echo && echo "Ping lookup: "
curl http://127.0.0.1:4161/ping

echo && echo "status nsq: "
curl http://127.0.0.1:4151/stats

echo && echo "Publishing first message and create a topic: "
curl -d "First Message $(date +%T)" "localhost:4151/pub?topic=firsttopic"

echo && echo "Creating a channel on nsqd: "
curl -X POST "http://127.0.0.1:4151/channel/create?topic=firsttopic&channel=pychann"

echo && echo "Admin nsqadmin on: http://localhost:4171/topics/firsttopic"

echo
