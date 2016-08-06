FROM alpine:latest
MAINTAINER Peter Winter <peter@pwntr.com>

# create dirs for the config, local mount point, and cloud destination
RUN mkdir /config /local /cloud

# update the base system
RUN apk update && apk upgrade

# install python 3 and git
RUN apk add python3 git && pip3 install --upgrade pip3

# install acd_cli
RUN pip3 install --upgrade git+https://github.com/yadayada/acd_cli.git

# no need for git or the apk cache anymore
RUN apk del git && rm -rf /var/cache/apk/*

VOLUME /config /local /cloud

ENTRYPOINT ["acd_cli"]

# by default, just show the help text. Command is overwritten by whatever you supply on the command line.
CMD ["--help"]
