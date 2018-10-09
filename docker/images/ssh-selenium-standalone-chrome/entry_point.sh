#!/usr/bin/env bash
service ssh start

/usr/bin/supervisord --configuration /etc/supervisord.conf
