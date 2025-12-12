FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y iproute2 iputils-ping net-tools vlan fping socat tcpdump pv && \
    apt clean 
    

CMD ["/bin/bash"]