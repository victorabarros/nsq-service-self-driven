# TODO alpine or slim, whos better?
FROM python:3.8-alpine

COPY . .

RUN pip3 install --no-cache pynsq

ENTRYPOINT ["python3"]
CMD ["reader.py"]
