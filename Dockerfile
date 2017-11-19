FROM ubuntu:16.04

RUN mkdir -p /usr/src/app
ADD . /usr/src/app
WORKDIR /usr/src/app
RUN chmod u+x corgi.sh \
    && apt-get update \
    && apt-get install apt-utils -y\
    && apt-get install sudo\
    && apt-get install unzip

