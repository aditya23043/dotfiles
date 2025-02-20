# Dotfiles / Configuration Files for my base Arch Installation
> Imagine using anything other than Arch lol

## Main Arch Installation

### Connect to the internet either by ethernet or wirelessly
```
$ iwctl station wlan0 connect PRIADI_5G
  > password: ***********
$ ping google.com
```

### Disk Partitioning, Formatting and Mounting
```
$ cfdisk /dev/nvme0n1
  > 500M EFI
  > Rest Linux Filesystem
  > Write
$ mkfs.vfat -F32 /dev/<EFI>
$ mkfs.ext4 /dev/<Linux FS>
$ mount /dev/<Linux FS> /mnt
```

### Install base packages
```
$ pacstrap -K /mnt base base-devel linux linux-firmware vim
```

### Chroot into the installation
```
$ arch-chroot /mnt
```

### Change Locale
```
$ vim /etc/locale.gen
  > en_US.UTF-8 UTF-8
$ locale-gen
```

### Change Hostname and DNS
```
$ vim /etc/hostname
  > archlinux
$ vim /etc/hosts
  > 127.0.0.1     localhost
  > ::1           localhost
  > 127.0.1.1     archlinux
```

### Generate initial ram disk for booting
```
$ mkinitcpio -P
```

### Change Root password
```
$ passwd
```

### Install some basic packages not included with the previous installation with pacstrap
```
$ pacman -S grub efibootmgr networkmanager sudo
```

### Setup GRUB (I use systemd-boot now) [OLD]
```
$ mkdir /boot/efi
$ mount /dev/<EFI> /boot/efi
$ grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
$ grub-mkconfig -o /boot/grub/grub.cfg
```

### Create User and add to groups
```
$ useradd -m adi
$ passwd adi
$ usermod -aG wheel,video,storage,audio adi
```

### Allow members of wheel group to execute anything (with sudo ofc)
```
$ visudo
  > %wheel ALL=(ALL:ALL) ALL
```

### Enable network manager for wireless connectivity
```
$ systemctl enable NetworkManager.service
```

### Cleanup
```
$ exit
$ umount -l /mnt
$ reboot
```
