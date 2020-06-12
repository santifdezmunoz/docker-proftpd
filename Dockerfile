FROM debian:stretch

LABEL maintainer="Santiago Fernández (santiago.fernandez@composistemas.es)"

RUN apt-get update -qq && \
	apt-get install -y proftpd && \
	apt-get install -y dnsutils && \
	apt-get install -y net-tools && \
	apt-get install -y vim && \
	apt-get install -y less && \
	apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sed -i "s/# DefaultRoot/DefaultRoot/" /etc/proftpd/proftpd.conf

EXPOSE 20 21

ADD docker-entrypoint.sh /usr/local/sbin/docker-entrypoint.sh
RUN chmod +x /usr/local/sbin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/sbin/docker-entrypoint.sh"]

CMD ["proftpd", "--nodaemon"]