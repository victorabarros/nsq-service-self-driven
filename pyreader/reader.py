from datetime import datetime
import nsq
import sys

TOPIC = 'hello_world'
CHANNEL = 'pychann'
URL = 'nsqlookupd'
PORT = 4161

sys.stdout.flush()

def handler(msg):
    print(msg.body.decode(),
          f"[{datetime.utcnow().strftime('%H:%M:%S.%f')}]",
          flush=True)
    return True

if __name__ == "__main__":
    r = nsq.Reader(message_handler=handler,
                   lookupd_http_addresses=[f'{URL}:{PORT}'],
                   topic=TOPIC,
                   channel=CHANNEL,
                   lookupd_poll_interval=15)

    nsq.run()
