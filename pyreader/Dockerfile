FROM python:3.10-alpine

COPY . .

RUN pip3 install --no-cache pynsq

ENTRYPOINT ["python3"]
CMD ["app.py"]
