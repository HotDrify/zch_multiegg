function motd {
    echo "
    ZachemHost | multiegg
    "
}

function JavaServer {
    java -Xms1024M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar paper-server.jar nogui
}

FILE=czch.txt

function OptimizeJavaServer {
  echo "view-distance=6" >> server.properties
  
}

if [ ! -f "$FILE" ]
then
    mkdir -p plugins
    motd
sleep 5
echo "
  which egg should you choose?

  1)  Forge          4) Python
  2)  BungeeCord
  3)  Node.js
"

read -r EGG
case $EGG in
  1) 
    sleep 1
    echo "enter MC version."
    read -r MC_VERSION
    apt install -y curl jq
    JSON_DATA=$(curl -sSL https://files.minecraftforge.net/maven/net/minecraftforge/forge/promotions_slim.json)
    if [[ "${MC_VERSION}" == "latest" ]] || [[ "${MC_VERSION}" == "" ]]; then
        echo -e "Download Forge for MC version $(MC_VEESION)"
        MC_VERSION=$(echo -e ${JSON_DATA} | jq -r '.promos | del(."latest-1.7.10") | del(."1.7.10-latest-1.7.10") | to_entries[] | .key | select(contains("latest")) | split("-")[0]' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | tail -1)rn    BUILD_TYPE=latestrn  firnrn  if [[ "${BUILD_TYPE}" != "recommended" ]] && [[ "${BUILD_TYPE}" != "latest" ]]; thenrn    BUILD_TYPE=recommendedrn  firnrn  echo -e "minecraft version: ${MC_VERSION}"rn  echo -e "build type: ${BUILD_TYPE}"rnrn
        