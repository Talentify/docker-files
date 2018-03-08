FROM selenium/standalone-chrome

RUN sudo apt-get -y update && sudo apt-get install -y openssh-server

USER root

COPY entry_point.sh /opt/bin/entry_point.sh

RUN chmod +x /opt/bin/entry_point.sh

ENTRYPOINT /opt/bin/entry_point.sh

USER seluser

EXPOSE 22