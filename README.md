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

## Post Installation Configuration

### Copy dotfiles from github repo
> TODO: change copy to link
```
mkdir $HOME/.config
git clone https://github.com/aditya23043/dotfiles
cp -r dotfiles/dmenu dotfiles/dwm dotfiles/st dotfiles/dunst dotfiles/fish $HOME/.config
cp dotfiles/.vimrc dotfiles/.tmux.conf $HOME/
```

### Install packages
```
sudo pacman -S --needed git fish chromium xorg xorg-xinit xorg-drivers libinput nvidia nvidia-settings nvidia-utils acpi bottom bluez bluez-libs bluez-utils blueman clang cmake dunst eza feh flameshot gvfs gvfs-gphoto2 gvfs-mtp libnotify lxappearance make mpv mtpfs ncdu nodejs npm ntfs-3g chrony openssh pavucontrol pipewire-alsa pipewire-audio pipewire-pulse pipewire-session-manager playerctl tar tldr ttf-jetbrains-mono-nerd unzip usbutils vulkan-headers wget xbindkeys xclip zip firefox thunar papirus-icon-theme zathura zathura-pdf-mupdf dosfstools mtools fish
```

### Add Tor Key
```
gpg --auto-key-locate nodefault,wkd --locate-keys torbrowser@torproject.org
```

### Install AUR packages
```
mkdir $HOME/AUR_packages
pico(){
  cd $HOME/AUR_packages && git clone https://aur.archlinux.org/$1 && cd $1 && makepkg -si && cd
}
pico tor-browser-bin
pico ybacklight
pico qogir-cursor-theme-git
pico vulkan-amdgpu-pro
pico transmission-gtk3
pico flat-remix-gtk
pico dracula-gtk-theme
pico otf-apple-fonts 
```

### Change Bash Shell to Fish Shell
```
chsh
```

### Initialize essential services
```
systemctl start bluetooth
systemctl start chronyd
```

### Set time zone
```
timedatectl set-timezone Asia/Kolkata
```

### Copy .xinitrc
```
cp /etc/X11/xinit/xinitrc $HOME/.xinitrc
chmod +x $HOME/.xinitrc
```

## Essential Tweaks

### Setup GitHub SSH key
```
git config --global user.email "adityascottish27@gmail.com"
git config --global user.name "Aditya Gautam"
ssh-keygen -t ed25519 -C "adityascottish27@gmail.com"
exec ssh-agent fish
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```

### Laptop Touchpad configuration
```
$ sudo vim /etc/X11/xorg.conf.d/30-touchpad.conf
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "TappingButtonMap" "lmr"
    Option "NaturalScrolling" "true"
EndSection
```

### Allow binaries to execute without sudo
```
$ sudo nvim /etc/sudoers
adi ALL=NOPASSWD: /bin/ybacklight
```

### Build vim (with clipboard support)
```
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge --enable-multibyte --with-x --prefix=/usr/local
```
