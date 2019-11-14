FROM ubuntu:xenial

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y --no-install-recommends \
    install telnet curl openssh-client nano vim-tiny iputils-ping build-essential \
    libssl-dev libffi-dev python3-pip python3-setuptools \
    python3-dev net-tools python3 software-properties-common \
    iproute2 dnsutils less vim iptables\
    && rm -rf /var/lib/apt/lists/* \
    && python3 -m pip uninstall pip && python3 -m pip install pip==19.3.1 \
    && pip3 install cryptography netmiko napalm pyntc \
    && pip3 install requests scapy ipython \
    && pip3 install --upgrade paramiko && mkdir /scripts \
    && mkdir /root/.ssh/ \
    && echo "KexAlgorithms diffie-hellman-group1-sha1,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1" > /root/.ssh/config \
    && echo "Ciphers 3des-cbc,blowfish-cbc,aes128-cbc,aes128-ctr,aes256-ctr" >> /root/.ssh/config

RUN echo "PS1='\\[\033[0;35m\\][\\u@\\h \\W]\\$\\[\\033[m\\]'" >> ~/.bashrc

VOLUME [ "/root","/usr", "/scripts" ]
CMD [ "sh", "-c", "cd; exec bash -i" ]
