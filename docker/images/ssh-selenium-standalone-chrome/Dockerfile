FROM selenium/standalone-chrome

RUN sudo apt-get -y update && sudo apt-get install -y openssh-server

USER root

RUN passwd -d root \
    && sed -i '/PermitRootLogin prohibit-password/c\PermitRootLogin yes' /etc/ssh/sshd_config \
    && sed -i '/Port 22/c\Port 1234' /etc/ssh/sshd_config \
    && service ssh restart

COPY entry_point.sh /opt/bin/entry_point.sh

RUN chmod +x /opt/bin/entry_point.sh

ENTRYPOINT /opt/bin/entry_point.sh

EXPOSE 1234