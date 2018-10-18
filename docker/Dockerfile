FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get -y install wget curl git p7zip-full zip build-essential xvfb fontconfig libfontconfig1 libdbus-1-3 libglib2.0-0 \
                       mesa-common-dev libjpeg8-dev libpng16-dev libgl1-mesa-dev rsync sudo ccache psmisc joe mc ncdu htop \
                       perl python '^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev libicu-dev libssl-dev

RUN apt-get -y install pkg-config libdbus-1-dev libudev-dev libglib2.0-dev libatspi2.0-dev libxft-dev libharfbuzz-dev libinput-dev libxkbcommon-dev libfontconfig1-dev libfreetype6-dev libpng-dev

VOLUME /home

RUN mkdir /workdir
VOLUME /workdir

VOLUME /home/builddev
