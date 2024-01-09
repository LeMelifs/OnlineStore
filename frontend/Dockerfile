FROM node:18
RUN mkdir -p /opt/app
WORKDIR /opt/app
COPY . /opt/app
RUN yarn install --ignore-engines
RUN yarn clean
RUN yarn build