from datetime import datetime
import nsq

TOPIC = 'firsttopic'
CHANNEL = 'pychann'
URL = 'nsqlookupd'
PORT = 4161

def handler(msg):
    print(f"[{datetime.utcnow().strftime('%H:%M:%S.%f')}] "+
          msg.body.decode())
    return True

if __name__ == "__main__":
    r = nsq.Reader(message_handler=handler,
                   lookupd_http_addresses=[f'{URL}:{PORT}'],
                   topic=TOPIC,
                   channel=CHANNEL,
                   lookupd_poll_interval=15)

    nsq.run()
