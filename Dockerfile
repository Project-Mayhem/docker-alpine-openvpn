#-- Usage Guide ----------------
# Docker build command:
# docker build --rm --no-cache -t "org.pm/alpine-openvpn:2.1" .
#
# docker run --rm -l openvpn -v ~/dev/git/minecraftsvr/data:/mcsdata diamondsfordays/alpine-minecraftsvr:1.11.2



FROM alpine:3.3

LABEL org.pm.alpine-openvpn.verison="2.1" \
      org.pm.alpine-openvpn.verison.image-specs="{ \
      \"Description\":\"Alpine-java container supporting openVPN client\", \
      \"java-version\":\"8\" \
      }"

MAINTAINER falenn

# set environment variables
ENV OPENVPN_VER=2.1 \
    OPENVPN_CONFIG_DIR="/opt/config/" \
    OPENVPN_CLIENT_CONFIG="client.ovpn"

# Modify the path
ENV PATH $OPENVPN_CONFIG_DIR:$PATH

# update Alpine for wget ssl support
RUN apk add --update --no-cache ca-certificates openssl bash sudo openvpn \
    && update-ca-certificates

# Copy over startup script
COPY entry.sh /usr/bin 

RUN chmod u+x /usr/bin/entry.sh

ENTRYPOINT ["entry.sh"]
