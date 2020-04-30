#version=F31

install

# Keyboard layout & Language
keyboard us
lang en_US.UTF-8

# Timezone
timezone Europe/Skopje

# Partitioning
clearpart --all --drives=sda
autopart --type=lvm --nohome --noswap

# Bootloader
bootloader --location=mbr

# Disable some stuff
firewall --disable
selinux --disabled

# Network settings 
network --bootproto=dhcp --ipv6=auto

# Users
rootpw --lock
user --name=weil --groups=wheel --password=testtest
sshkey --username=weil "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILsfv6VBTn7dGQMyviq1YvB1n6/V9KZErtr4oZdBcNse WeilNET Ansible"

# Packages
%packages 
curl
coreutils
sed
%end

# Services
services --disabled=cockpit

text

%post
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
%end

reboot 
