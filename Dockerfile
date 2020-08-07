


FROM ubuntu:14.04

MAINTAINER Nanda Kishor "nkd@24hourkirtan.fm"
ENV DEBIAN_FRONTEND noninteractive

#Install wget
RUN apt-get update && apt-get install -y wget
RUN apt-get update && apt-get install -y git

#get latest stable build of Icecast from Xiph.org
RUN sh -c "echo deb http://download.opensuse.org/repositories/multimedia:/xiph/xUbuntu_14.04/ ./ >>/etc/apt/sources.list.d/xiph.list" && \
RUN  git clone  https://github.com/elasa-Sites/heroku-icecast-radio-docker\
     cd heroku-icecast-radio-docker\
	 chmod 755 *\
	 sh -c "./test-2-by-docker.sh"


