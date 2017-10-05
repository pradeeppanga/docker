FROM centos:7

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

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5000 8082

