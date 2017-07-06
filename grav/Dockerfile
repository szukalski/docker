FROM nginx:latest
MAINTAINER David James <szukalski@gmail.com>

RUN apt-get update \
	&& apt-get install -y \
	zip unzip git php7.0-fpm php7.0-cli php7.0-gd php7.0-curl php7.0-mbstring php7.0-xml php7.0-zip php-apcu\
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*


