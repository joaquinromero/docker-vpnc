# docker-vpnc

[![Docker Repository on Quay.io](https://quay.io/repository/azavea/vpnc/status "Docker Repository on Quay.io")](https://quay.io/repository/azavea/vpnc)
[![Apache V2 License](http://img.shields.io/badge/license-Apache%20V2-blue.svg)](https://github.com/hectcastro/docker-sneaker/blob/develop/LICENSE)

A `Dockerfile` based off of [`phusion/baseimage-docker`](https://github.com/phusion/baseimage-docker) that establishes a VPN connection with [`vpnc`](https://www.unix-ag.uni-kl.de/~massar/vpnc/).

## Environment Variables

- `VPNC_GATEWAY`: IP/name of your IPSec gateway
- `VPNC_ID`: Group name
- `VPNC_SECRET`: Group password
- `VPNC_USERNAME`: XAUTH username
- `VPNC_PASSWORD`: XAUTH password

## Usage

First, ensure that all of the environment variables above exist in a file:

```bash
$ cat > .env <<EOF
VPNC_GATEWAY=1.2.3.4
VPNC_ID=joker-group
VPNC_SECRET=joker-secret
VPNC_USERNAME=joker
VPNC_PASSWORD=joker-password
EOF
```

**Note**: You can also use the `-e` option to `docker run`.

Next, build the container:

```bash
$ docker build -t azavea/vpnc .
```

Lastly, run the container.

```bash
$ docker run --rm --name imatia_vpn --privileged --env-file .env --net=host -d azavea/vpnc 
```

**Option Explanations**

- `--rm`: Removes the container after it's done executing
- `--privileged`: Allows the container to create and make use of the `tun` device
- `--env-file`: Loads up the contents of `.env` into the container's environment
- `--net=host`: see http://www.dasblinkenlichten.com/docker-networking-101-host-mode/

```cmd
> route -p add <vpns_ips> MASK 255.255.255.0 <docker_container_ip (should be like 10.0.75.X)>
```


**Note**: If you get an error like the one below, it is a [known bug](https://bugs.launchpad.net/ubuntu/+source/vpnc/+bug/228365) with `vpnc`:

```
select: Interrupted system call
terminated by signal: 15
```
