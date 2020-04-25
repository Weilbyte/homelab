#version=F32

# Repositories 
install
url --mirrorlist="https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-32&arch=x86_64&country=cz"
repo --name=fedora-updates --mirrorlist="https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f32&arch=x86_64&country=cz" --cost=0
# RPMFusion Open-Source
repo --name=rpmfusion-free --mirrorlist="https://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-32&arch=x86_64" --includepkgs=rpmfusion-free-release
repo --name=rpmfusion-free-updates --mirrorlist="https://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-released-32&arch=x86_64" --cost=0
repo --name=rpmfusion-free-tainted --mirrorlist="https://mirrors.rpmfusion.org/metalink?repo=free-fedora-tainted-32&arch=x86_64"
# RPMFusion Redistributable
repo --name=rpmfusion-nonfree --mirrorlist="https://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-32&arch=x86_64" --includepkgs=rpmfusion-nonfree-release
repo --name=rpmfusion-nonfree-updates --mirrorlist="https://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-released-32&arch=x86_64" --cost=0
repo --name=rpmfusion-nonfree-tainted --mirrorlist="https://mirrors.rpmfusion.org/metalink?repo=nonfree-fedora-tainted-32&arch=x86_64"

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
network --bootproto=dhcp --ipv6=dhcp 

# Users
rootpw testtest

# Packages
%packages 
curl
coreutils
sed
salt-minion
%end

# Services
services --disabled=cockpit --enabled=salt-minion

text

%post
/usr/bin/sed -i 's/#master: salt/master: salt.srv.dhcp.weilbyte.net/g' /etc/salt/minion
%end

reboot 
