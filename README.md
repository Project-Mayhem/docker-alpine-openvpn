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

-v is the mount of a local directory containing your "client.ovpn" configuration file.
#
# DNS Issues
If on a Mac and need to add DNS server,
http://apple.stackexchange.com/questions/50962/how-to-add-some-additional-dns-search-domains-without-ignoring-the-dhcp-ones
