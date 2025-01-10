FROM debian:latest

WORKDIR /tmp

# RUN apk update && apk add --no-cache --update-cache wget make gcc g++ zlib-dev gcompat libstdc++ ncurses-dev jansson-dev patch libedit libedit-dev util-linux-dev libxml2-dev sqlite-dev libxml2-dev
RUN apt update && apt install -y wget make gcc g++ openssl ncurses-dev libjansson-dev patch libedit-dev libxml2-dev libsqlite3-dev libxml2-dev bzip2 uuid-dev doxygen graphviz kmod && apt clean



# RUN wget -q -O /etc/apt/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
# RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r1/glibc-2.35-r1.apk
# RUN apk add glibc-2.35-r1.apk

# Install Prerequisites
# RUN wget https://downloads.asterisk.org/pub/telephony/dahdi-linux-complete/dahdi-linux-complete-current.tar.gz
# RUN tar -xf dahdi-linux-complete-current.tar.gz -C /usr/local/src
RUN apt update && apt install -y dahdi dahdi-dkms dahdi-linux && apt clean
RUN apt update && apt install libpri1.4 libpri-dev && apt clean

#WORKDIR /usr/local/src/dahdi-linux-complete-3.4.0+3.4.0

#RUN make && make install && make install-config

WORKDIR /tmp

RUN wget https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-22-current.tar.gz
RUN tar xvzf asterisk-22-current.tar.gz -C /usr/local/src

WORKDIR /usr/local/src/asterisk-22.1.1

RUN contrib/scripts/install_prereq install
RUN ./configure
RUN ls /usr/local/src
RUN make
RUN make menuconfig
RUN ./contrib/scripts/get_mp3_source.sh 
RUN make install
RUN make progdocs
RUN make install-logrotate
RUN make samples
RUN make config
RUN ldconfig

EXPOSE 5060
EXPOSE 5060/udp
EXPOSE 4569/udp

ENTRYPOINT ["/usr/sbin/asterisk", "-cvvvvv"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]
