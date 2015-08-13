FROM ubuntu:14.04

# Install LXDE, VNC server 
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  wget \
  uzip \
  lxde-core \
  lxterminal \
  tightvncserver
# Set user for VNC server (USER is only for build)
ENV USER root
# Set default password
COPY password.txt .
RUN cat password.txt password.txt | vncpasswd && \
  rm password.txt
# Expose VNC port
EXPOSE 5901

# Copy VNC script that handles restarts
COPY vnc.sh /opt/

RUN apt-get install -yqq wget unzip

WORKDIR /tmp
RUN wget http://ftp.squeak.org/5.0/Squeak-5.0-All-in-One.zip
RUN unzip Squeak-5.0-All-in-One.zip 
RUN yes | /tmp/Squeak-5.0-All-in-One/Squeak-5.0-All-in-One.app/Contents/LinuxAndWindows/install-libs32

CMD ["/opt/vnc.sh"]
#CMD [/tmp/Squeak-$VERsiON-All-in-One/squeak.sh]
