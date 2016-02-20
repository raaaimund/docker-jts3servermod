#!/bin/bash

echo "Starting JTS3ServerMod ..."
sudo -u ${JTS3_USER} java ${JTS3_JAVA_ARGS} -jar "$JTS3_DIR/JTS3ServerMod.jar"