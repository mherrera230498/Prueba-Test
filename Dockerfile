FROM node:18

ENV DATABASE_NAME="./devDocker.sqlite"
ENV DATABASE_USER="userDocker"
ENV DATABASE_PASSWORD="passwordDocker"
ENV PORT="8000"

WORKDIR /app
COPY . .

RUN npm install

ENTRYPOINT ["npm"]
CMD ["run", "start"]