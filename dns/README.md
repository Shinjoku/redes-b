# DNS cache
This is where you'll find everything done to the machine in order to setup de DNS cache.

## Getting Started
You should be connected to your EC2 instance to make these modifications.

In this service, we'll only configure one DNS server. This server will search in its cache and, if the search doesn't bring any results, the server will call others servers with forwarders.

### Installing

First, update your system
```
sudo apt-get update
```
Install Bind
```
sudo apt-get install bind9 bind9utils bind9-doc
```
Set bind to operate with IPv4. For this, we need to go to /etc/default/bind9 and change the variable **OPTIONS** to have the parameter "-4"
```
OPTIONS="-4 -u bind"
```
This tutorial wont have any port changes. Only IP redirections for the DNS search.#


### Configuring Primary DNS Server
We need to go to /etc/bind/named.conf and change his content to allow the forwardness and to allow our searches.

#### On /etc/bind/named.conf:

Add your IP to the trusted list (don't forget the ; in the end)
```
acl "trusted" {
    <your_IP>;
}
```
In the options section, let's add our option to enable recursive queries on  trusted clients, disable transfers by default and especify the forwarders address
```
options {
        directory "/var/cache/bind";

        recursion yes;                 # enables resursive queries
        allow-recursion { trusted; };  # allows recursive queries from "trusted" clients
        listen-on { 10.128.10.11; };   # ns1 private IP address - listen on private network only
        allow-transfer { none; };      # disable zone transfers by default

        forwarders {
                8.8.8.8;
                8.8.4.4;
        };
...
};
```
Save and exit

#### On named.conf.local
Here we can specify our forward and reverse zones

We should add our domain name like a zone and our ip too, point both to its respective files that we'll create soon
```
zone "clausenezerbetto.com" {
    type master;
    file "/etc/bind/zones/db.clausenezerbetto.com";
};

zone "31.172.in-addr.arpa" {
    type master;
    file "/etc/bind/zones/db.31.172";  
};
```
Save and exit.

### Creating a Forward Zone File
We should create a folder /etc/bind/zones
```
sudo mkdir /etc/bind/zones
```
And then we can use our local file, that already exists, as a template for the new zone
```
sudo cp /etc/bind/db.local /etc/bind/zones/db.clausenezerbetto.com
```
Now, we should change "localhost. root.localhost." to our domains, something like
```
...
@   IN  SOA clausenezerbetto.com. admin.clausenezerbetto.com.
...
```
One important thing to do is increase the serial number, right under the domain name line
```
...
            3   ;Serial
....
```
Then, add the name servers of your dns
```
; name servers - NS records
    IN  NS  dns1.clausenezerbetto.com.
```
But, this is not enough for redirecting our search. After this, we should say what's the dns address. In my case, it was like
```
...
dns1.clausenezerbetto.com.  IN  A   172.31.11.55
...
```
And now is the time where we can make the records for our hosts
```
; 172.31.11.55 - A records
www.clausenezerbetto.com.   IN  A   172.31.11.55
smtp.clausenezerbetto.com.  IN  A   172.31.11.55
ftp.clausenezerbetto.com.   IN  A   172.31.11.55
```
Save and exit

### Creating Reverse Zone File
Almost the same as before, but now we have to deal with IP Address directly

Begin with copying the local file as a template for your changes.
Note that the IP is kinda reversed on the file name. This is right, and you should do the same.
```
cd /etc/bind/zones
sudo cp ../db.127 ./db.31.172
```

#### On db.31.172
Just remember that your file should have a different name, because our IPs possibly won't have the same mask.

Here we change the "localhost. root.localhost." part to our dns address that we set before
```
@       IN      SOA     dns1.clausenezerbetto.com. admin.clausenezerbetto.com. (
            3   ; Serial
```
Don't forget to increase the serial number!

Delete the two records on the end of the file and add your records
```
; name servers - NS records
      IN      NS      dns1.clausenezerbetto.com.
```
Then you should add the IP Addresses that you want to find at your searches
```
;PTR records
; PTR records
55.11   IN      PTR     dns1.clausenezerbetto.com.      ; 172.31.11.55
55.11   IN      PTR     www.clausenezerbetto.com.       ; 172.31.11.56
55.11   IN      PTR     smtp.clausenezerbetto.com.      ; 172.31.11.57
55.11   IN      PTR     ftp.clausenezerbetto.com.       ; 172.31.11.58
```
Save and exit

### Configure DNS Clients
Now we have to tell our system to use this server that we made.

#### On /etc/resolvconf/resolv.conf.d/head
Add the lines to select the dns1 IP Address
```
search clausenezerbetto.com
nameserver 172.31.11.55
```
Now to generate a new resolv.conf file, run
```
sudo resolvconf -u
```

## Running the tests

### The service is working?
You can use **nslookup** on linux-based systems to search for the addresses.
```
nslookup <ip_you_want_to_search>
```
You can always search for the domain name too
```
nslookup clausenezerbetto.com
```


## Built with
[BIND](https://www.isc.org/downloads/bind/) - The DNS Server

## Thanks to
*[Digital Ocean](http://www.digitalocean.com/) - for the [tutorial](https://www.digitalocean.com/community/tutorials/how-to-configure-bind-as-a-private-network-dns-server-on-ubuntu-14-04).
