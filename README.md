# About
Apline-openvpn contains the necesary dependencies to use openvpn.  My concept is that one uses this image to build or link to other images that need to leverage openVPN for their networking needs.

# Usage
To run:

docker run \
      --name openvpn \
      -v config:/opt/config \
      -l openvpn \
      -it \
      --cap-add=NET_ADMIN \
      --device=/dev/net/tun \
      org.pm/alpine-openvpn:2.1

--device allows the tunnel to form

--cap-add allows Docker-machine to extend privileges to this container to modify the network stack.

-v is the mount of a local directory containing your "client.ovpn" configuration file, for instance:

config/client.ovpn
config/resolv.conf (any DNS servers you need to add)

If you create a config dir in the cloned project, it will be ignored by git (check out .gitignore)

#
# DNS
If within a vpn you need to add a different dns server, you'll need to update /etc/reslv.conf.

create a resolv.conf file that you want to append to /etc/resolv.conf and place it in your config dir.  The file will get mounted in with your client.ovpn and entry.sh will cat the contents into /etc/resolv.conf.

###  totally separate, but hindered my development
If on a Mac and need to add DNS server,
http://apple.stackexchange.com/questions/50962/how-to-add-some-additional-dns-search-domains-without-ignoring-the-dhcp-ones
