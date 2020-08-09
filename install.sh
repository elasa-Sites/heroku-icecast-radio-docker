
################
#based of :
#https://medium.com/@shikendon/build-an-icecast-streaming-server-on-heroku-using-docker-ac3492b554f0

################

#install Docker for ubuntu 18.04 from https://linuxize.com/post/how-to-install-and-use-docker-on-ubuntu-18-04/

sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update
apt-cache policy docker-ce

sudo apt install docker-ce -y
sudo systemctl status docker



install fandogh :

sudo apt-get install -y python3-pip

pip3 install fandogh-cli --upgrade

fandogh login --username ss2test --password ss123456 

mkdir your-project-name
cd your-project-name

git init

cat << 'EOT' > Dokerfile

FROM centos:7
MAINTAINER "John Smith" <your@email.com>
RUN yum -y update && yum clean all
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-12.noarch.rpm
RUN yum -y install icecast
RUN yum -y install applydeltarpm
RUN sed -ri "s/<bind-address>127.0.0.1<\/bind-address>/<bind-address>0.0.0.0<\/bind-address>/g" /etc/icecast.xml
CMD sed -ri "s/<port>8000<\/port>/<port>$PORT<\/port>/g" /etc/icecast.xml && /bin/icecast -c /etc/icecast.xml
FROM ubuntu:14.04

MAINTAINER Nanda Kishor "nkd@24hourkirtan.fm"

ENV DEBIAN_FRONTEND noninteractive

#Install wget
RUN apt-get update && apt-get install -y wget
RUN apt-get update && apt-get install -y git
RuN apt-get install -y nano

#get latest stable build of Icecast from Xiph.org
RUN sh -c "echo deb http://download.opensuse.org/repositories/multimedia:/xiph/xUbuntu_14.04/ ./ >>/etc/apt/sources.list.d/xiph.list" 
RUN  git clone  https://github.com/elasa-Sites/heroku-icecast-radio-docker
RUN  cd heroku-icecast-radio-docker
CMD [chmod 755 *]
CMD ["/test-2-by-docker.sh"] "./test-2-by-docker.sh"
ADD ./test-2-by-docker.sh /test-2-by-docker.sh
#ADD ./etc /etc
EOT

chmod 755 Dokerfile

#instal heroku CLI :
sudo curl https://cli-assets.heroku.com/install.sh | sh

#IF use Docker lab form docker .com
apk add --update npm
npm i -g heroku



heroku plugins:install @heroku-cli/heroku-container-registry


heroku create

heroku container:login

#heroku  -a $APP_NAME  container:push web .
heroku   --recursive container:push web .
#heroku container:release web --app=my-app-12355

heroku   container:push web .

#heroku access -a shielded-beyond-90893 container:push web

heroku open
