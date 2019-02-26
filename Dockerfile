FROM jlesage/baseimage-gui:ubuntu-18.04

RUN apt-get update -y && \
    sed -i '/messagebus/d' /var/lib/dpkg/statoverride && \
    apt-get install -y git-sh python2.7 pkg-config python-gtk2-dev libgconf2-dev libxml-parser-perl python-hachoir-metadata python-eyed3 python-gnome2-dev && \
    cd / && \
    git clone https://github.com/SteveRyherd/pyRenamer.git && \
    cd /pyRenamer && \
    ./configure --prefix /usr && \
    make && \
    make install && \
    echo "#!/bin/sh" >> /startapp.sh && \
    echo "export HOME=/config" >> /startapp.sh && \
    echo 'mkdir -p "`python -m site --user-site`"' >> /startapp.sh && \
    echo 'cp -r /usr/lib/python2.7/site-packages/pyrenamer "`python -m site --user-site`"' >> /startapp.sh && \
    echo "/usr/bin/pyrenamer --root /storage" >> /startapp.sh && \
    chmod a+x /startapp.sh && \
    rm -rf /var/lib/apt/lists/*

ENV APP_NAME="pyRenamer"
