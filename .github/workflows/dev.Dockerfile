FROM ubuntu:20.04

# https://serverfault.com/a/1016972 to ensure installing tzdata does not
# result in a prompt that hangs forever.
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get -y update
RUN apt-get -y install git nodejs npm
RUN npm install --global yarn
