FROM node:lts-alpine3.17

WORKDIR /app

COPY . .

RUN npm install --omit=dev

CMD [ "npm", "start" ]
