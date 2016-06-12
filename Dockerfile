FROM phusion/baseimage:0.9.16

CMD ["/sbin/my_init"]

RUN apt-get update -y && apt-get install -y vpnc && apt-get install -y iptables

# Setup vpnc service
RUN mkdir -p /etc/service/vpnc
COPY bin/vpnc.sh /etc/service/vpnc/run
COPY bin/01_iptables.sh /etc/my_init.d/01_iptables.sh
#COPY bin/01_iptables.sh /data/01_iptables.sh

# Clean up
RUN apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
