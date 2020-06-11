docker-proftpd
==============

Simple way to install a proftp server on an host.

Quick start
-----------

```bash
docker run -d --net host \
	-e FTP_LIST="user1:pass1;user2:pass2" \
	-v /path_to_ftp_dir_for_user1:/home/user1 \
	-v /path_to_ftp_dir_for_user2:/home/user2 \
	kibatic/proftpd
```

Warning
-------

The way to define the users and passwords makes that you should not
use ";" or ":" in your user name or password.

(ok, this is ugly, but using FTP in 2018 is ugly too)

USERADD_OPTIONS
---------------

```bash
docker run -d --net host \
	-e FTP_LIST="user1:pass1;user2:pass2" \
	-e USERADD_OPTIONS="-o --gid 33 --uid 33" \
	-v /path_to_ftp_dir_for_user1:/home/user1 \
	-v /path_to_ftp_dir_for_user2:/home/user2 \
	kibatic/proftpd
```

The USERADD_OPTIONS is not mandatory. It contains parameters we can
give to the useradd command (in order for example to indicates the
created user can have the uid of www-data (33) ).

It allows to give different accesses, but each user will create
the files and directory with the right user on the host.

Deploying the container behind a NAT
-------------------------------------
If you need to deploy the container behind a NAT you can use the variable 
PUBLICIP for configuring the MasqueradeAddress setting in the proftpd.conf file.

You can use an IP addres or a FQDN DNS name.

```bash
docker run -d --net host \
	-e FTP_LIST="user1:pass1;user2:pass2" \
	-e PUBLICIP="1.2.3.4" \
	-v /path_to_ftp_dir_for_user1:/home/user1 \
	-v /path_to_ftp_dir_for_user2:/home/user2 \
	kibatic/proftpd
```

The proftpd service is configured for using the passive ports range 
from 30000 to 30005

docker-compose.yml example
--------------------------

You can for example use a docker-compose like this :

```yaml
version: '3.7'

services:
  proftpd:
    image: kibatic/proftpd
    network_mode: "host"
    restart: unless-stopped
    environment:
      FTP_LIST: "myusername:mypassword"
      USERADD_OPTIONS: "-o --gid 33 --uid 33"
    volumes:
      - "/the_direcotry_on_the_host:/home/myusername"
```

Author
------

This is a fork from the work of Philippe Le Van. You can see his original work at [kibatic/docker-proftpd](https://github.com/kibatic/docker-proftpd)
