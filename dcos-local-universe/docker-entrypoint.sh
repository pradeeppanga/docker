#!/bin/bash

set -e

/usr/sbin/init

set -x \
	&& systemctl enable docker \
	&& systemctl start docker

set -x \
       && git clone https://github.com/mesosphere/universe.git --branch version-3.x \
       && cd universe/docker/local-universe \
       && make base \
       && make DCOS_VERSION=1.9.2 DCOS_PACKAGE_INCLUDE="$(cat /tmp/package-list)" local-universe \
       && docker load < local-universe.tar.gz

#set -x \
#       && sh -c "docker load < /universe/docker/local-universe/local-universe.tar.gz"

set -x \
       && systemctl daemon-reload \
       && systemctl enable dcos-local-universe-http \
       && systemctl enable dcos-local-universe-registry
