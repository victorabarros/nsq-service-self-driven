echo "Installing Curl"
apk add curl

TOPIC_NAME="firsttopic"
URL="nsqd"
PORT="4151"  # TODO: Move commom variables to global envs(ports, topics and channels)

echo "Publishing message to ${TOPIC_NAME} topic"

while true
do
    NOW=$(date +%T)
    echo "${NOW} publishing"
    curl -d "m ${NOW}" "${URL}:${PORT}/pub?topic=${TOPIC_NAME}"
    echo && sleep .2
done
