FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y openssh-server sudo python3 && \
    mkdir -p /var/run/sshd && \
    useradd -m -s /bin/bash ansible && \
    echo "ansible:ansible" | chpasswd && \
    usermod -aG sudo ansible && \
    echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible && \
    chmod 0440 /etc/sudoers.d/ansible && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
