FROM golang:latest
MAINTAINER Prawn
USER root

ENV SNMP_COMMUNITY="public"
ENV SNMP_RETRIES=1
ENV SNMP_TRAP_ADDRESS="localhost:162"
ENV WEBHOOK_ADDRESS="0.0.0.0:9099"
ENV LOGLEVEL=info

EXPOSE 9099

ADD bin/linux/snmp-trapper /usr/local/bin/snmp-trapper
COPY sample-alert.json /
RUN ls -la /usr/local/bin/
RUN chmod 770 /usr/local/bin/snmp-trapper

CMD exec /usr/local/bin/snmp-trapper -snmpcommunity=$SNMP_COMMUNITY -snmpretries=$SNMP_RETRIES -snmptrapaddress=$SNMP_TRAP_ADDRESS -webhookaddress=$WEBHOOK_ADDRESS -loglevel=$LOGLEVEL

