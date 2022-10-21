#!/bin/bash

sudo apt install ssh -y
sudo apt install proftpd -y

mdpc1=$(perl -e 'print crypt("kalimac", "salt")')
mdpc2=$(perl -e 'print crypt("secondbreakfast", "salt")')

sudo useradd -m -p $mdpc1 Merry
sudo useradd -m -p $mdpc2 Pippin

sudo cp /etc/proftpd/proftpd.conf /etc/proftpd/proftpd.conf.save
echo "<Anonymous ~ftp>
User ftp
Group nogroup
UserAlias anonymous ftp
DirFakeUser on ftp
DirFakeGroup on ftp
RequireValidShell off
MaxClients 10
DisplayLogin welcome.msg
DisplayChdir .message

<Directory *>
<Limit WRITE>
AllowAll
</Limit>
</Directory>

<Directory incoming>
<Limit READ WRITE>
AllowAll
</Limit>
</Directory>
</Anonymous>

">> proftpd.conf

sudo systemctl restart proftpd
sudo systemctl status proftpd
