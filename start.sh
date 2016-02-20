#!/bin/bash

cp -rn "$JTS3_TEMP_DIR/JTS3ServerMod/config" "$JTS3_DIR/config"
cp -rn "$JTS3_TEMP_DIR/JTS3ServerMod/plugins" "$JTS3_DIR/plugins"
cp "$JTS3_TEMP_DIR/JTS3ServerMod/JTS3ServerMod.jar" ${JTS3_DIR}

# clear
rm -rf ${JTS3_TEMP_DIR}

ls -la ${JTS3_TEMP_DIR}

echo "Starting JTS3ServerMod ..."
java ${JTS3_JAVA_ARGS} -jar "$JTS3_DIR/JTS3ServerMod.jar"