FROM java:8-jre

MAINTAINER raimund@rittnauer.at

ENV JTS3SERVERMOD_URL http://www.stefan1200.de/dlrequest.php?file=jts3servermod&type=.zip
ENV JTS3_DIR "/home/jts3servermod"
ENV JTS3_TEMP_DIR "/home/temp"
ENV JTS3_JAVA_ARGS "-Xmx256M"
ENV JTS3_USER "jts3servermod"
ENV JTS3_UID 1000

ADD start.sh /start.sh

RUN apt-get -qq update \
    && apt-get -qq install -y \
    bsdtar \
    && apt-get -qq clean \
    && apt-get -qq autoremove --purge -y \
    && useradd -u ${JTS3_UID} ${JTS3_USER} \
    && mkdir -p ${JTS3_DIR} \
    && mkdir -p ${JTS3_TEMP_DIR} \
    && chown ${JTS3_USER} /start.sh \
    && chown -R ${JTS3_USER} ${JTS3_DIR} \
    && chmod 755 /start.sh \
    && wget -q -O- ${JTS3SERVERMOD_URL} \
    # -O- load .zip in stdout
    | bsdtar -xf- -C ${JTS3_TEMP_DIR} \
    && rm -rf "$JTS3_TEMP_DIR/JTS3ServerMod/tools" "$JTS3_TEMP_DIR/JTS3ServerMod/readme*" "$JTS3_TEMP_DIR/JTS3ServerMod/documents" "JTS3_TEMP_DIR/JTS3ServerMod/changelog.txt" \
    && cp -rfn "$JTS3_TEMP_DIR/JTS3ServerMod/config" "$JTS3_DIR/config" \
    && cp -rfn "$JTS3_TEMP_DIR/JTS3ServerMod/plugins" "$JTS3_DIR/plugins" \
    && cp -rf "$JTS3_TEMP_DIR/JTS3ServerMod/JTS3ServerMod.jar" "$JTS3_DIR/JTS3ServerMod.jar" \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ${JTS3_TEMP_DIR}

WORKDIR ${JTS3_DIR}

USER ${JTS3_USER}
ENTRYPOINT ["/start.sh"]
VOLUME [${JTS3_DIR}]

# pass parameters to entrypoint
# CMD [""]