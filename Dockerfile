FROM kaixhin/vnc

RUN apt-get install -yqq wget unzip
ENV VERSION 5.0
COPY http://ftp.squeak.org/$VERSION/Sqeak-$VERSION-All-in-One.zip /tmp/squeak.zip
RUN unzip /tmp/sqeak.zip /opt/
RUN /opt/Squeak-$VERSION-All-in-One/Squeak-$VERSION-All-in-One.app/Contents/LinuxAndWindows/install-lib32

#CMD [/opt/Squeak-$VERsiON-All-in-One/squeak.sh]
