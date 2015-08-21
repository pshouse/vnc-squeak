FROM ubuntu:14.04

RUN dpkg --add-architecture i386
RUN apt-get update 
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y libc6:i386 lib32z1 lib32ncurses5 lib32bz2-1.0 libX11-6:i386 libice6:i386 libgl1-mesa-dri-lts-utopic:i386
RUN apt-get install -y libgl1-mesa-glx-lts-utopic:i386 libsm6:i386 
RUN apt-get install -y \
  wget \
  unzip \
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

WORKDIR /tmp
RUN wget http://ftp.squeak.org/5.0/Squeak-5.0-All-in-One.zip
RUN unzip Squeak-5.0-All-in-One.zip 
#RUN yes | /tmp/Squeak-5.0-All-in-One/Squeak-5.0-All-in-One.app/Contents/LinuxAndWindows/install-libs32
RUN cp Squeak-5.0-All-in-One /opt/
COPY Squeak5.0-15113.image
COPY Squeak5.0-15113.changes
COPY xstartup /root/.vnc/.
CMD ["/opt/vnc.sh"]
#CMD [/tmp/Squeak-$VERsiON-All-in-One/squeak.sh]
