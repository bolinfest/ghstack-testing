FROM ubuntu:20.04

# https://serverfault.com/a/1016972 to ensure installing tzdata does not
# result in a prompt that hangs forever.
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get -y update
RUN apt-get -y install curl git

# The default version of Node on Ubuntu 20.04 is v10,
# so use a PPA to get a newer version
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
RUN apt-get install -y nodejs

# Create and populate a Yarn offline-mirror.
RUN npm install --global yarn
RUN yarn config set offline-mirror "$HOME/npm-packages-offline-cache"
RUN yarn install
RUN find $(yarn config get offline-mirror)
