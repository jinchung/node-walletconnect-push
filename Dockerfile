FROM node:11
MAINTAINER admin@rainbow.me

RUN apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get -y install build-essential ssh \
                       ruby ruby-dev rubygems \

RUN gem install --no-ri --no-rdoc fpm

WORKDIR /usr/src/app

COPY . .

RUN npm ci --only=production

ARG VERSION
RUN fpm -n node-walletconnect-push -v ${VERSION} \
        --deb-systemd=systemd/node-walletconnect-push.service \
        --after-install=debian/postinst \
        -s dir -t deb .

ADD private-deb-repo-key .
RUN tar -c *.deb | ssh -oStrictHostKeyChecking=no -i /usr/src/app/private-deb-repo-key apt@apt.rainbow.me
