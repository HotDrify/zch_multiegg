#!/bin/bash

function motd() {
    echo "ZachemHost | multiegg"
}

mkdir -p plugins
motd
sleep 5
echo "
which egg should you choose?

1)  Forge          3) Python
2)  Node.js
"
read -r EGG
case $EGG in 
1)
    sleep 1
    
    echo "Enter MC version or latest"
    read -r MC_VERSION
    
    echo "Enter fabric version or latest"
    read -r FABRIC_VERSION
    
    echo "Enter loader version or latest"
    read -r LOADER_VERSION
    
    mkdir -p /mnt/server
    cd /mnt/server
    
    if [ -z "$MC_VERSION" ] || [ "$MC_VERSION" == "latest" ]; then
        MC_VERSION=$(curl -sSL https://meta.fabricmc.net/v2/versions/game | jq -r '.[] | select(.stable== true )|.version' | head -n1)
    elif [ "$MC_VERSION" == "snapshot" ]; then
        MC_VERSION=$(curl -sSL https://meta.fabricmc.net/v2/versions/game | jq -r '.[] | select(.stable== false )|.version' | head -n1)
    fi
    
    if [ -z "$FABRIC_VERSION" ] || [ "$FABRIC_VERSION" == "latest" ]; then
        FABRIC_VERSION=$(curl -sSL https://meta.fabricmc.net/v2/versions/installer | jq -r '.[0].version')
    fi
    
    if [ -z "$LOADER_VERSION" ] || [ "$LOADER_VERSION" == "latest" ]; then
        LOADER_VERSION=$(curl -sSL https://meta.fabricmc.net/v2/versions/loader | jq -r '.[] | select(.stable== true )|.version' | head -n1)
    elif [ "$LOADER_VERSION" == "snapshot" ]; then
        LOADER_VERSION=$(curl -sSL https://meta.fabricmc.net/v2/versions/loader | jq -r '.[] | select(.stable== false )|.version' | head -n1)
    fi
    
    echo "Installing Fabric ${FABRIC_VERSION}"
    
    wget -O fabric-installer.jar https://maven.fabricmc.net/net/fabricmc/fabric-installer/$FABRIC_VERSION/fabric-installer-$FABRIC_VERSION.jar
    java -jar fabric-installer.jar server -mcversion $MC_VERSION -loader $LOADER_VERSION -downloadMinecraft
    mv server.jar minecraft-server.jar
    mv fabric-server-launch.jar server.jar
    echo "serverJar=minecraft-server.jar" > fabric-server-launcher.properties
    echo -e "Install Complete."
    ;;
2)
    sleep 1
    
    echo "Enter JS filename"
    read -r JS_FILENAME
    
    echo "Installing nodeJS 18.X"
    
    curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs
    echo -e "Install Complete."
    
    ;;
3)
    
esac

if [ -f $JS_FILENAME ]; then
    node $JS_FILENAME
fi

if [ -f server.jar ]; then
    java -Xms128M -Xmx1024M -jar server.jar
fi