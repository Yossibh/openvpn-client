FROM debian:jessie
MAINTAINER David Personette <dperson@dperson.com>

# Install openvpn
RUN export DEBIAN_FRONTEND='noninteractive' && \
    apt-get update -qq && \
    apt-get install -qqy --no-install-recommends openvpn \
                $(apt-get -s dist-upgrade|awk '/^Inst.*ecurity/ {print $2}') &&\
                apt-get install -qqy iptables && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*
COPY openvpn.sh /usr/bin/
COPY nat.sh /tmp/

RUN chmod 777 /tmp/nat.sh
RUN chmod +x /tmp/nat.sh
RUN sudo /tmp/nat.sh

VOLUME ["/vpn"]

ENTRYPOINT ["openvpn.sh"]
