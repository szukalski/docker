FROM httpd:2.4
MAINTAINER szukalski <szukalski@gmail.com>

RUN apt-get update && apt-get install -y \
    git \
    rtorrent \
    libapache2-mod-scgi \
    unrar \
    unzip \
    ffmpeg \
    mediainfo \
    --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
    && a2enmod rewrite \
    && a2enmod ssl \
    && a2enmod auth_digest \

