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
    display
sleep 5
echo "
  which egg should you choose?

  1)  Forge          4) Python
  2)  BungeeCord
  3)  Node.js
"

read -r egg
case $egg in
  1) 
    sleep 1
    read -r version
    echo "Downloading Forge $version..."