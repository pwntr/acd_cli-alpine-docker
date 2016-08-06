FROM alpine:latest
MAINTAINER Peter Winter <peter@pwntr.com>

# create dirs for the config, local mount point, and cloud destination
RUN mkdir /config /cache /local /cloud

# set the cache, settings, and libfuse path accordingly
ENV ACD_CLI_CACHE_PATH /cache
ENV ACD_CLI_SETTINGS_PATH /config
ENV LIBFUSE_PATH /usr/lib/libfuse.so.2.9.6

# update the base system
RUN apk update && apk upgrade

# install python 3, fuse, and git
RUN apk add python3 fuse git && pip3 install --upgrade pip

# install acd_cli
RUN pip3 install --upgrade git+https://github.com/yadayada/acd_cli.git

# no need for git or the apk cache anymore
RUN apk del git && rm -rf /var/cache/apk/*

VOLUME /config /cache /local /cloud

ENTRYPOINT ["acd_cli"]

# by default, just show the help text. Command is overwritten by whatever you supply on the command line.
CMD ["--help"]
