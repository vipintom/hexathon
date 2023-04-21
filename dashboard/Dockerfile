FROM alpine
RUN mkdir -p /app
WORKDIR /app
COPY . /app
EXPOSE 4500
RUN apk add --no-cache nodejs npm
RUN npm install
