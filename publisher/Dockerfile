FROM alpine:3.15.0

COPY ./run.sh ./run.sh
RUN apk add --no-cache curl util-linux

ENTRYPOINT ["sh", "./run.sh"]
