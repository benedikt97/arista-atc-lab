set -x

j2 dualhomed.j2 sdf-server1.yaml > startscripts/sdf-server1.sh
j2 dualhomed.j2 sdf-server2.yaml > startscripts/sdf-server2.sh
j2 dualhomed.j2 center-position1.yaml > startscripts/center-position1.sh
j2 dualhomed.j2 tower-position1.yaml > startscripts/tower-position1.sh
j2 dualhomed.j2 rec-server.yaml > startscripts/rec-server.sh
j2 dualhomed.j2 radar.yaml > startscripts/radar.sh
j2 default.j2 tower-cam1.yaml > startscripts/tower-cam1.sh
j2 default.j2 tower-df1.yaml > startscripts/tower-df1.sh
j2 default.j2 radar-cam1.yaml > startscripts/radar-cam1.sh