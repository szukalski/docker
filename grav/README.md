# docker-grav
A docker image from ALPINE Linux with NGINX, PHP-FPM through unix socket and preinstalled GRAV.

Includes Admin and Git Sync plugins.

docker run -d -p 80:80 --name grav szukalski/grav:latest
docker exec grav sh -c 'cd /www && php bin/gpm install XYZ'
