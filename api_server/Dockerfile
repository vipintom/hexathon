FROM python:3.9-alpine

RUN mkdir -p /app
WORKDIR /app
COPY . /app
EXPOSE 80
RUN pip install --no-cache-dir --upgrade -r requirements.txt