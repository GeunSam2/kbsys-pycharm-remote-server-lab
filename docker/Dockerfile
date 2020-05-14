FROM ubuntu
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y  bash git openssh-server rsync augeas-tools libdbd-mysql-perl python && \
    deluser $(getent passwd 33 | cut -d: -f1) && \
    delgroup $(getent group 33 | cut -d: -f1) 2>/dev/null || true && \
    mkdir -p /root/.ssh && chmod 700 /root/.ssh/ &&\
    augtool 'set /files/etc/ssh/sshd_config/PermitRootLogin "yes"' && \
    augtool 'set /files/etc/ssh/sshd_config/AuthorizedKeysFile ".ssh/authorized_keys .ssh/authorized_keys2"' && \
    augtool 'set /files/etc/ssh/sshd_config/PermitEmptyPasswords "yes"'
RUN apt-get install -y curl
RUN curl -O https://raw.githubusercontent.com/pypa/get-pip/master/get-pip.py
RUN python get-pip.py 
RUN pip --version

COPY project /project
WORKDIR /project
RUN apt-get install -y postgresql mysql-server
RUN pip install -r requirements.txt
RUN systemd-tmpfiles --create
RUN mkdir -p /run/sshd
COPY start.sh /start.sh

EXPOSE 22

CMD bash /start.sh 
