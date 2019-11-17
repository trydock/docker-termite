FROM ubuntu:18.04

WORKDIR "/home/anish"

RUN mkdir -p /home/anish && \
    apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    build-essential git g++ libgtk-3-dev gtk-doc-tools \
    gnutls-bin valac intltool libpcre2-dev libglib3.0-cil-dev \
    libgnutls28-dev libgirepository1.0-dev libxml2-utils gperf && \
    cd /home/anish && \
    git clone https://github.com/thestinger/vte-ng.git && \
    echo export LIBRARY_PATH="/usr/include/gtk-3.0:$LIBRARY_PATH" && \
    cd vte-ng && \
    ./autogen.sh && \
    make && \
    make install && \
    cd /home/anish && \
    git clone --recursive https://github.com/thestinger/termite.git && \
    cd termite && \
    make && \
    make install && \
    ldconfig && \
    mkdir -p /lib/terminfo/x && \
    ln -s /usr/local/share/terminfo/x/xterm-termite /lib/terminfo/x/xterm-termite && \
    update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/termite 60
