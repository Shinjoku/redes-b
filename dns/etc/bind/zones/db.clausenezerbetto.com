;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     dns1.clausenezerbetto.com. admin.clausenezerbetto.com. (
                              6         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
; name servers - NS records
        IN      NS      dns1.clausenezerbetto.com.
        IN      NS      dns2.clausenezerbetto.com.
;
; name servers - A records
dns1.clausenezerbetto.com.      IN      A       172.31.11.55
dns2.clausenezerbetto.com.      IN      A       172.31.11.55
; 172.31.11.55 - A records
smtp.clausenezerbetto.com.      IN      A       172.31.11.55
www.clausenezerbetto.com.       IN      A       172.31.11.55
ftp.clausenezerbetto.com.       IN      A       172.31.11.55
