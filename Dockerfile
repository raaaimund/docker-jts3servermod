FROM java:8-jre

MAINTAINER raimund@rittnauer.at

ENV JTS3SERVERMOD_URL http://www.stefan1200.de/dlrequest.php?file=jts3servermod&type=.zip
ENV JTS3_DIR="/home/jts3servermod"
ENV JTS3_JAVA_ARGS="-Xmx256M"

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh && \
    apt-get -qq update && \
    apt-get -qq install bsdtar sudo -y && \
    mkdir -p "$JTS3_DIR" && \
    wget -q -O- "$JTS3SERVERMOD_URL" | \
    bsdtar -xf- -C "$JTS3_DIR" && \
    rm -rf "$JTS3_DIR/tools" "$JTS3_DIR/readme*" "$JTS3_DIR/documents" "$JTS3_DIR/changelog.txt" && \
    cp -rf "$JTS3_DIR/config" "$JTS3_DIR/default_config" && \
    apt-get -qq clean && \
    apt-get -qq autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR "$JTS3_DIR"

USER jts3servermod
ENTRYPOINT ["/entrypoint.sh"]
VOLUME ["$JTS3_DIR/config"]

# pass arguments to script
CMD [""]