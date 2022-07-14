# Generated by Anaconda 36.16.5
# Generated by pykickstart v3.36
#version=F36
# Use graphical install
graphical

# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=dhcp --device=eno1 --ipv6=auto --activate
network  --hostname=workstation

# Use network installation
url --url="http://{{ ansible_default_ipv4.address }}/f36-inst.local/"

%packages
@^workstation-product-environment

%end

# Run the Setup Agent on first boot
firstboot --enable --reconfig

# Generated using Blivet version 3.4.3
#ignoredisk --only-use=nvme0n1
#autopart --encrypted
autopart --encrypted --passphrase workstation
# Partition clearing information
#clearpart --none --initlabel
clearpart --initlabel --all

# System timezone
timezone America/Chicago --utc

#Root password
rootpw --lock
#user --groups=wheel --name=raven --password=$y$j9T$PPOsnYE40GwL3Q5vgNN.YaFn$W6uIV74vTi7Mz5O0RAfCgIFMDIbHEughnvd4nJ/6XA0 --iscrypted --gecos="raven"

#user --groups=wheel --name=user --password=workstation --gecos="user"
%post --log=/root/post.log

exec < /dev/tty1 > /dev/tty1
chvt 1

dnf install ansible wget -y

wget http://{{ ansible_default_ipv4.address }}/f36-inst.local/plays/workstation-post.yml

ansible-playbook workstation-post.yml

chvt 6

%end