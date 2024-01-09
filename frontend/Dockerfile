FROM node:18
RUN mkdir -p /opt/frontend
WORKDIR /opt/frontend
COPY . /opt/frontend
RUN yarn install --ignore-engines
RUN yarn quasar clean
RUN yarn build
