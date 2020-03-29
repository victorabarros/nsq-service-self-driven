# apk add curl
apk add --no-cache curl util-linux

TOPIC_NAME="firsttopic"
URL="nsqd"
PORT="4151"  # TODO: Move commom variables to global envs(ports, topics and channels)

while true
do
    NOW=$(date +%T)
    ID=$(uuidgen -r)
    echo "${ID}-${NOW}"
    curl -d "${ID}-${NOW}" "${URL}:${PORT}/pub?topic=${TOPIC_NAME}"
    sleep .2
done
