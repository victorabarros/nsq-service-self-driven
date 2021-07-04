FROM alpine:3.11

COPY ./publish.sh ./publish.sh
RUN apk add --no-cache curl util-linux

ENTRYPOINT ["sh", "./publish.sh"]
