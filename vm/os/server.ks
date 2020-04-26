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
