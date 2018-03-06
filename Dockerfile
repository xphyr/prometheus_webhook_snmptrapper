FROM golang:latest
USER root

ENV SNMP_COMMUNITY="public"
ENV SNMP_RETRIES=1
ENV SNMP_TRAP_ADDRESS="0.0.0.0:8162"
ENV WEBHOOK_ADDRESS="0.0.0.0:9099"
ENV LOGLEVEL=info

EXPOSE 9099 8086

ADD bin/linux/snmp-trapper /usr/local/bin/snmp-trapper
COPY sample-alert.json /

CMD exec /usr/local/bin/snmp-trapper -snmpcommunity=$SNMP_COMMUNITY -snmpretries=$SNMP_RETRIES -snmptrapaddress=$SNMP_TRAP_ADDRESS -webhookaddress=$WEBHOOK_ADDRESS -loglevel=$LOGLEVEL

