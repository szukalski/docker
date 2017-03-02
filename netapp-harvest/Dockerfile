FROM ubuntu:16.04
MAINTAINER David James <szukalski@gmail.com>

RUN apt-get update && apt-get install -y \
	unzip \
	perl \
	libjson-perl \
	libwww-perl \
	libxml-parser-perl \
	liblwp-protocol-https-perl \
	libexcel-writer-xlsx-perl \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

COPY netapp-harvest_*_all.deb /
COPY netapp-manageability-sdk-*.zip /

RUN dpkg -i netapp-harvest_*_all.deb \
	&& unzip -j netapp-manageability-sdk-*.zip netapp-manageability-sdk-*/lib/perl/NetApp/* -d /opt/netapp-harvest/lib \
	&& rm /netapp-harvest_*_all.deb \
	&& rm /netapp-manageability-sdk-*.zip

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
