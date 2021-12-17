# build
# https://docs.docker.com/samples/library/node/
ARG NODE_VERSION=16.13.1

FROM node:${NODE_VERSION}-alpine

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

WORKDIR /home/node/app

COPY package*.json ./
COPY wait-for ./
COPY wait-for-postgres.sh ./

USER node

RUN yarn install

COPY --chown=node:node . .

EXPOSE 3000

# ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.2.1/wait /wait
# RUN chmod +x /wait

# CMD /wait && yarn dev
CMD ["yarn", "dev"]