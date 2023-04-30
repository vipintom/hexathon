FROM alpine
RUN mkdir -p /app
WORKDIR /app
COPY . /app
EXPOSE 3000
RUN apk add --no-cache nodejs npm
RUN npm install
#RUN npm run build