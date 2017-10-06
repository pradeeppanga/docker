FROM centos:7

ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]

COPY docker.repo /etc/yum.repos.d
COPY dcos-local-universe-http.service /etc/systemd/system/
COPY dcos-local-universe-registry.service /etc/systemd/system/
COPY package-list /tmp/
COPY docker-entrypoint.sh /usr/local/bin

RUN set -x \
 	&& yum update -y \
	&& yum install -y openssl zip make git wget \
	&& wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
	&& yum install -y epel-release-latest-7.noarch.rpm \ 
	&& curl -LO https://centos7.iuscommunity.org/ius-release.rpm \
	&& rpm -ivh ius-release.rpm \
	&& yum install -y python36u python36u-pip \
	&& ln -s /bin/python3.6m /bin/python3 \
	&& yum install -y docker-engine-1.11.2 \
	&& yum install -y supervisor

RUN ln -s usr/local/bin/docker-entrypoint.sh /

EXPOSE 5000 8082

ENTRYPOINT ["/docker-entrypoint.sh"]

