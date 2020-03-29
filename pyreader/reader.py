# Consumer inside of /nsqlookupd container
from datetime import datetime
import nsq

TOPIC = 'firsttopic'
CHANNEL = 'pychann'
URL = 'nsqlookupd'
PORT = 4161


def handler(msg):
    print(datetime.utcnow().isoformat()[11:],
          'msg: ',
          msg.body.decode())
    return True


r = nsq.Reader(message_handler=handler,
               lookupd_http_addresses=[f'{URL}:{PORT}'],
               topic=TOPIC,
               channel=CHANNEL,
               lookupd_poll_interval=15)

nsq.run()
