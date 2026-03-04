FROM ghcr.io/srl-labs/clab

RUN apk update
RUN apk add python3
RUN apk add py3-pip
ADD requirements.txt / 
RUN pip3 install -r requirements.txt --break-system-packages


CMD ["/bin/bash"]
