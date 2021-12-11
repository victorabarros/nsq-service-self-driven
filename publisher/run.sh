TOPIC_NAME="hello_world"
URL="nsqd"
PORT="4151"  # TODO: Move commom variables to global envs(ports, topics and channels) or move to docker-compose or Makefile

while true
do
    NOW=$(date +%T)
    ID=$(uuidgen -r)
    PAYLOAD="{\"id\":${ID},\"createdAt\":${NOW}}"
    printf "\n${PAYLOAD}"
    curl -s -d ${PAYLOAD} "${URL}:${PORT}/pub?topic=${TOPIC_NAME}"
    sleep 2
done
