FROM ubuntu:20.04
RUN apt-get -y update
RUN apt-get -y install git nodejs npm
# RUN npm install --global yarn
