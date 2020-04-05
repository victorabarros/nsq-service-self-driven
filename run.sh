echo "                   _ __   ___   __ _                   " && sleep .2
echo "                  | '_ \ / __| / _' |                  " && sleep .2
echo "                  | | | |\__ \| (_| |                  " && sleep .2
echo "                  |_| |_||___/ \__, |                  " && sleep .2
echo "                                  | |                  " && sleep .2
echo "                                  |_|                  " && sleep .2
echo "            _   __  ______        _                    " && sleep .2
echo "           | | / _| |  _  \      (_)                   " && sleep .2
echo " ___   ___ | || |_  | | | | _ __  _ __   __ ___  _ __  " && sleep .2
echo "/ __| / _ \| ||  _| | | | || '__|| |\ \ / // _ \| '_ \ " && sleep .2
echo "\__ \|  __/| || | _ | |/ / | |   | | \ V /|  __/| | | |" && sleep .2
echo "|___/ \___||_||_|(_)|___/  |_|   |_|  \_/  \___||_| |_|" && sleep .2
echo "                                                       " && sleep .2
echo "                                                       " && sleep .2
# from http://patorjk.com/software/taag font doom


echo && echo "Kill containers and images: "
docker rm -f nsq-service-self-driven_nsqadmin_1 \
    nsq-service-self-driven_nsqd_1 \
    nsq-service-self-driven_nsqlookupd_1 \
    nsq-service-self-driven_writer_1 \
    nsq-service-self-driven_pyreader_1 \
    nsq-service-self-driven_goreader_1
# Images:
docker rmi -f nsqio/nsq:v1.2.0 \
    nsq-service-self-driven_writer \
    nsq-service-self-driven_pyreader \
    nsq-service-self-driven_goreader \
    golang:1.14-alpine

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
