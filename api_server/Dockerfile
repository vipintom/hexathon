FROM python:3.9-alpine

RUN mkdir -p /app
WORKDIR /app
COPY . /app
EXPOSE 80
RUN apk add mariadb-dev gcc musl-dev 
RUN pip install --upgrade -r requirements.txt