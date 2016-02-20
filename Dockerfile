FROM java:8-jre

MAINTAINER raimund@rittnauer.at

ENV JTS3SERVERMOD_URL http://www.stefan1200.de/dlrequest.php?file=jts3servermod&type=.zip
ENV JTS3_DIR "/home/jts3servermod"
ENV JTS3_TEMP_DIR "/home/temp"
ENV JTS3_JAVA_ARGS "-Xmx256M"
ENV JTS3_UID 1000

RUN apt-get -qq update \
    && apt-get -qq install -y \
    bsdtar \
    sudo \
    && apt-get -qq clean \
    && apt-get -qq autoremove --purge -y \
    && useradd -u ${JTS3_UID} jts3servermod \
    && mkdir -p ${JTS3_DIR} \
    && mkdir -p ${JTS3_TEMP_DIR} \
    && wget -q -O- ${JTS3SERVERMOD_URL} \
    # -O- load .zip in stdout
    | bsdtar -xf- -C ${JTS3_TEMP_DIR} \
    && rm -rf "$JTS3_TEMP_DIR/JTS3ServerMod/tools" "$JTS3_TEMP_DIR/JTS3ServerMod/readme*" "$JTS3_TEMP_DIR/JTS3ServerMod/documents" "JTS3_TEMP_DIR/JTS3ServerMod/changelog.txt" \
    && cp -rfn "$JTS3_TEMP_DIR/JTS3ServerMod/config" "$JTS3_DIR/config" \
    && cp -rfn "$JTS3_TEMP_DIR/JTS3ServerMod/plugins" "$JTS3_DIR/plugins" \
    && cp -rf "$JTS3_TEMP_DIR/JTS3ServerMod/JTS3ServerMod.jar" "$JTS3_DIR/JTS3ServerMod.jar" \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ${JTS3_TEMP_DIR} \
    && java ${JTS3_JAVA_ARGS} -jar "$JTS3_DIR/JTS3ServerMod.jar"

WORKDIR "$JTS3_DIR"

USER jts3servermod

VOLUME ["$JTS3_DIR"]

# pass parameters to entrypoint
CMD [""]