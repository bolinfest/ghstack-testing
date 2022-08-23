FROM ubuntu:20.04

# https://serverfault.com/a/1016972 to ensure installing tzdata does not
# result in a prompt that hangs forever.
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get -y update
RUN apt-get -y install curl git

# The default version of Node on Ubuntu 20.04 is v10,
# so use a PPA to get a newer version
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

# Debugging: where am I?
RUN mkdir /root/node-project
WORKDIR /root/node-project
ADD yarn.lock /root/node-project
ADD package.json /root/node-project
RUN pwd
RUN ls

# Create and populate a Yarn yarn-offline-mirror.
RUN npm install --global yarn
RUN yarn config set yarn-offline-mirror "$HOME/npm-packages-offline-cache"
RUN yarn install
RUN find $(yarn config get yarn-offline-mirror)
