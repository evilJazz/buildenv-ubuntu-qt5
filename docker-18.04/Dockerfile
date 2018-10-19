FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y install wget curl git p7zip-full zip build-essential rsync sudo ccache psmisc joe mc ncdu htop \
                       perl python qt5-default qtdeclarative5-dev libjpeg-dev libpng-dev

VOLUME /home

RUN mkdir /workdir
VOLUME /workdir

VOLUME /home/buildenv
