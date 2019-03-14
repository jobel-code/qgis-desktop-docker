FROM ubuntu:bionic
MAINTAINER drjobel
# ORIGINAL SOURCE OF INSPIRATION: [Julien ANCELIN](https://github.com/jancelin/docker-qgis-desktop/)

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

ENV TZ=Europe/Stockholm

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


RUN apt-get -y update
RUN apt-get install -y gnupg apt-transport-https ca-certificates

RUN echo "deb https://qgis.org/ubuntu-nightly-ltr bionic main" >> /etc/apt/sources.list
RUN gpg --keyserver keyserver.ubuntu.com --recv CAEB3DC3BDF7FB45
RUN gpg --export --armor CAEB3DC3BDF7FB45 | apt-key add -
RUN apt-get update && \
    apt-get install -y qgis python-qgis qgis-provider-grass \
    locales locales-all && \
    rm -rf /var/lib/apt/lists/*
#--no-install-recommends

#locales
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8



# Called when the Docker image is started in the container
ADD start.sh /start.sh
RUN chmod 0755 /start.sh

CMD /start.sh
