#!/bin/bash

echo 'root:test1234' | chpasswd
/usr/sbin/sshd
python /project/manage.py runserver 0:80
