## OpenVPN
### Initialise
´´´
docker-compose run --rm openvpn ovpn_genconfig -u udp://{vpn_server_address}
docker-compose run --rm openvpn ovpn_initpki
´´´
### Generate and exportclient cert
´´´
docker-compose run --rm openvpn easyrsa build-client-full {client_name}
docker-compose run --rm openvpn ovpn_getclient {client_name} > certificate.ovpn
´´´
Use ´´´nopass´´´ as an option for generating the client cert
