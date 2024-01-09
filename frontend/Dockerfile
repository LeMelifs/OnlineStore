FROM node:18
RUN mkdir -p /opt/app
WORKDIR /opt/app
COPY . /opt/app
RUN yarn install --ignore-engines
RUN yarn quasar clean
RUN yarn build