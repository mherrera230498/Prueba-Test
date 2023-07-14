FROM node:18-alpine

#ENV DATABASE_NAME="./devDocker.sqlite"
#ENV DATABASE_USER="dbUser"
#ENV DATABASE_PASSWORD="dbPass"

RUN apk --no-cache add curl

USER node

WORKDIR /home/node/app

COPY ./package*.json ./

RUN npm ci

COPY . .

HEALTHCHECK --interval=10s --timeout=3s \
  CMD curl -f http://localhost:8000/api/users || exit 1

EXPOSE 8000

ENTRYPOINT ["node"]
CMD ["index.js"]