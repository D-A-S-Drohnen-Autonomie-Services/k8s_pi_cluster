# Setting up DNS server

Creating a DNS server on the primary node, allowing you to assign internal network addresses to names.

A significant amount of this tutorial is taken from [here](https://tecadmin.net/configure-dns-server-on-ubuntu-linuxmint/)

## Installation

We will be using BIND to run the server so run the following commands on the primary server:

```shell
sudo apt update 
sudo apt install bind9 -y 
```

## Setting up the domain

General information:

We will be creating the domain `dastech.local`, on the ip address range 192.168.60.0/24. You can change the values as you need in this document.

### Create the Forward Zone File

create the BIND file for the domain below is the parameters required

```shell
sudo vi /etc/bind/{domain}.zone
```

Here is what it would look like for the domain I am creating

```shell
sudo vi /etc/bind/dastech.local.zone
```

Insert the following \[you can replace dastech.local with your domain\]:

```text
; Forward Zone file for dastech.local
$TTL 14400
@      86400    IN      SOA     ns1.dastech.local. webmaster.dastech.local. (
                3013040200      ; serial, todays date+todays
                86400           ; refresh, seconds
                7200            ; retry, seconds
                3600000         ; expire, seconds
                86400           ; minimum, seconds
      )
ns1             IN A 192.168.50.50
ns2             IN A 192.168.50.50
dastech.local.   86400  IN        NS      ns1.dastech.local.
dastech.local.          IN        A       192.168.60.1
www                     IN        CNAME   dastech.local. 
```

Then save, and test the file like so:

Generic name:
```shell
sudo named-checkzone {domain} /etc/bind/{domain}.zone 
```

Here it is for dastech.local:

```shell
sudo named-checkzone dastech.local /etc/bind/dastech.local.zone 
```

### Create the Reverse Zone File

Optional but recommended, you will use the IP range that you would like to work on, if you do not know how IP ranges work you should learn about that first.

Using the IP range 192.168.60.0/24 for my internal network, you choose your own.

Create the file as follows:


```shell
sudo vi /etc/bind/db.60.168.192
```

Add the following, do not forget to replace `dastech.local` with your domain.

```text
; BIND reverse data file for local loopback interface
;
$TTL    604800
@ IN SOA ns1.dastech.local. root.ns1.dastech.local. (
                     3013040200         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns1.dastech.local.
100     IN      PTR     dastech.local.

```

Then save and check the file using the following command:

```shell
named-checkzone 192.168.60.0/24 /etc/bind/db.60.168.192
```

That should be correct and now you should load the configuration into BIND.

### Updating BIND config

Edit the BIND config

```shell
sudo vi /etc/bind/named.conf.local 
```

Add the following lines, replace the domain and IP range appropriately:

```text
zone "{domain}" IN {
        type master;
        file "/etc/bind/{domain}.zone";
};
 
zone "{ip_range}.in-addr.arpa" {
        type master;
        file "/etc/bind/db.{ip_range}";
};
```

For my configuration it would look like this:

```text
zone "dastech.local" IN {
        type master;
        file "/etc/bind/dastech.local.zone";
};

zone "60.168.192.in-addr.arpa" {
        type master;
        file "/etc/bind/db.60.168.192";
};
```

Save the file and check the configuration files:

```shell
named-checkconf  /etc/bind/named.conf.local 
named-checkconf  /etc/bind/named.conf 
```

No output means everything is ok.

Restart BIND through the following commands:

```shell
sudo systemctl restart bind9 
```

Check BIND status through the following command:

```shell
sudo systemctl status bind9 
```

When BIND is up you can test your domain on the primary node:


```shell
dig @{primary_server_ip} {domain}
```

For `dastech.local`:

```shell
dig @127.0.0.1 dastech.local
```

Output should be similar to this:

```text

; <<>> DiG 9.18.18-0ubuntu2-Ubuntu <<>> @127.0.0.1 dastech.local
; (1 server found)
;; global options: +cmd
;; Got answer:
;; WARNING: .local is reserved for Multicast DNS
;; You are currently testing what happens when an mDNS query is leaked to DNS
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 44109
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 2e5dbc1bec763a5a01000000656b38f185515074f62be343 (good)
;; QUESTION SECTION:
;dastech.local.                 IN      A

;; ANSWER SECTION:
dastech.local.          14400   IN      A       192.168.60.1

;; Query time: 0 msec
;; SERVER: 127.0.0.1#53(127.0.0.1) (UDP)
;; WHEN: Sat Dec 02 14:02:25 UTC 2023
;; MSG SIZE  rcvd: 86
```

You can check the Reverse IP lookup:

```shell
dig @127.0.0.1 -x 192.168.60.100
```

Will output the following:

```text
; <<>> DiG 9.18.18-0ubuntu2-Ubuntu <<>> @127.0.0.1 -x 192.168.60.100
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 20705
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: a85ec1214974533401000000656b3930f50703d1714a6148 (good)
;; QUESTION SECTION:
;100.60.168.192.in-addr.arpa.   IN      PTR

;; ANSWER SECTION:
100.60.168.192.in-addr.arpa. 604800 IN  PTR     dastech.local.

;; Query time: 0 msec
;; SERVER: 127.0.0.1#53(127.0.0.1) (UDP)
;; WHEN: Sat Dec 02 14:03:28 UTC 2023
;; MSG SIZE  rcvd: 111
```

## Configure your nodes to use the primary server's DNS

In order to use the DNS on your Ubuntu Nodes you will need to do the following.

Update the `/etc/resolv.conf` file on the nodes this is a specific configuration for your setup. 

The following command will do most of the work in an automated way.

```shell
sudo cat /etc/resolv.conf >> ~/resolv.conf.bck
sudo mv ~/resolv.conf.bck /etc/resolv.conf.bck
sudo rm /etc/resolv.conf
sudo cp /etc/resolv.conf.bck /etc/resolv.conf
```

Now the base configuration from your node has been statically set, by running the following command:

```shell
sudo cat /etc/resolv.conf
```

You should see the output:

```text
# This is /run/systemd/resolve/stub-resolv.conf managed by man:systemd-resolved(8).
# Do not edit.
#
# This file might be symlinked as /etc/resolv.conf. If you're looking at
# /etc/resolv.conf and seeing this text, you have followed the symlink.
#
# This is a dynamic resolv.conf file for connecting local clients to the
# internal DNS stub resolver of systemd-resolved. This file lists all
# configured search domains.
#
# Run "resolvectl status" to see details about the uplink DNS servers
# currently in use.
#
# Third party programs should typically not access this file directly, but only
# through the symlink at /etc/resolv.conf. To manage man:resolv.conf(5) in a
# different way, replace this symlink by a static file or a different symlink.
#
# See man:systemd-resolved.service(8) for details about the supported modes of
# operation for /etc/resolv.conf.

nameserver 127.0.0.53
options edns0 trust-ad
search .
```

Now we need to clean up this static file since the notes at the top are no longer relevant, now you can edit the file and remove all the comments:

```shell
sudo nano /etc/resolv.conf
```

Change the file to match the following, you need to set the `primary_node_ip` appropriately:

```text
nameserver 127.0.0.53
nameserver {primary_node_ip}
options edns0 trust-ad
search .
```

For the example so far I will replace it with my primary_node_ip:

```text
nameserver 192.168.50.50
nameserver 127.0.0.53
options edns0 trust-ad
search .
```

This will be active immediately, so you are good to go.