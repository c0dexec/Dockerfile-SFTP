FROM alpine:latest

# Can change the group and user variable to your own needs.
ENV grp=sftpg
ENV usr=sftp

RUN apk update && apk add openssh openssh-server

# Switcing to 'root' user.
USER root
RUN addgroup ${grp}

# Password-less user creation.
RUN adduser -D -G ${grp} ${usr}

# https://stackoverflow.com/questions/28721699/root-password-inside-a-docker-container
# Password goes here encoded in base64.
RUN echo -e "`echo 'encoded-in-base64' | base64 -d`\n`echo 'encoded-in-base64' | base64 -d`" | passwd ${usr} 
RUN mkdir -p /data/${usr}/upload
RUN chown -R root.${grp} /data/$usr
RUN chown -R ${usr}.${grp} /data/${usr}/upload

# Setting up a mount location
VOLUME [ "/data/${usr}/upload" ]

# https://stackoverflow.com/questions/43235179/how-to-execute-ssh-keygen-without-prompt 
RUN ssh-keygen -A
COPY authorized_keys /home/${usr}/.ssh/authorized_keys

# Configurations to set a home directory for the group.
RUN echo -e "Match Group sftpg\n\tChrootDirectory /data/%u\n\tForceCommand internal-sftp" >> /etc/ssh/sshd_config
ENTRYPOINT [ "/usr/sbin/sshd", "-D" ]

EXPOSE 22