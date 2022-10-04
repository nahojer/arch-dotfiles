# Installation Guide

This guide gives rough instructions on how to install the dotfiles on a fresh Arch Linux install.

## Step 1: Boot ISO

Enter Arch Linux ISO installer.

## Step 2: Connect to Internet

List devices:

```
iwctl device list
```

If powered off, run:

```
rfkill unblock all
```

Then connect with (replace wlan0 with whatever device you have):

```
iwctl wlan0 station get-networks/scan/connect
```

Enable DHCP:

```
dhcpcd wlan0
```

## Step 3: Install Arch

Run `archinstall` and select i3-gaps (desktop environment), pipewire (audio) and add your user to the "video" group. Furthermore, choose to install the following packages:

- networkmanager
- network-manager-applet
- modemmanager
- Usb_modeswitch
- dhcpcd
- wpa_supplicant

## Step 4: Post Installation

Run:

```
systemctl enable ModemManager.service
systemctl start ModemManager.service

systemctl enable NetworkManager.service
systemctl start NetworkManager.service

systemctl enable dhcpcd.service
systemctl start dhcpcd.service
```

Verify that you have internet: `ping 8.8.8.8`.

Reboot.

## Step 4: Inside i3

Connect to wifi using systray in i3bar.

Create directories:

```
mkdir -p $HOME/{Downloads,Work,Projects}
mkdir -p $HOME/Pictures/{Wallpapers,Screenshots}
```

Install pacman packages:

```
sudo pacman -S git zsh stow exa neovim firefox
```

Clone dotfiles:

```
cd $HOME && cit clone https://github.com/nahojer/.dotfiles.git
```

Install zsh config:

```
cd $HOME/.dotfiles
stow zsh
```

Add the following to /etc/zsh/zshenv:

```
export ZDOTDIR="$HOME/.config/zsh
```

Change shell to zsh:

```
chsh -s $(which zsh)
```

Reboot.

Install more pacman packages:

```
sudo pacman -S pamixer alacritty stow tmux western picom rofi sxhkd zathura wget curl noto-fonts-emoji ttf-dejavu ttf-linux-libertine ttf-fira-mono otf-fira-mono ttf-fira-code feh dunst clipmenu tree unzip mpd flameshot neomutt playerctl man xclip fzf pulsemixer lazygit ttf-joypixels ttf-font-awesome ripgrep btop ncmpcpp stylua lightdm-webkit2-greeter rofi-emoji light shfmt eslint_d shellcheck luarocks fd delve pass
```

[Install Go](https://go.dev/doc/install).

Install Go tools:

```
go install golang.org/x/tools/cmd/goimports@latest
```

Install Rust:

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Install yay:

```
cd $HOME/Downloads
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
```

Install yay packages:

```
yay -S bitwarden cava ttf-jetbrains-mono nerd-fonts-complete ttf-icomoon-feather ttf-all-the-icons ttf-material-design-icons polybar autotiling networkmanager-dmenu-git python-pip i3lock-fancy-git spotify-tui prettierd python-black fixjson write-good lazydocker spotifyd
```

Configure wget:

```
cd $HOME/.dotfiles
stow wget
```

[Install nvm](https://github.com/nvm-sh/nvm).

Install npm:

```
cd $HOME/.dotfiles
stow npm
nvm install node
```

Install file manager:

```
env CGO_ENABLED=0 go install -ldflags="-s -w" github.com/gokcehan/lf@latest
pip install ueberzug
cd $HOME/.dotfiles
stow lf
```

Get rid of beeps by adding the following to /etc/modprobe.d/nobeep.conf:

```
blacklist pcspkr
```

Setup pass:

```
mkdir -p .local/share/gnupg
chmod -R 0700 $HOME/.local/share/gnupg
gpg --gen-key
pass init <my-email-address>
```

Enable spotifyd:

```
pass insert spotify
stow spotifyd
systemctl --user enable spotifyd.service --now
```

Stow everything in $HOME/.dotfiles.

Note, first time you enter nvim you are going to be fed with a wall of errors. Run `:PackerSync` and re-enter nvim again to fix the issues.

Also, some i3 and polybar configurations are probably gonna break depending on what hardware you are running (e.g. battery device, etc.). How to find out what devices you need is commented in the configuration files.

Reboot.

Be happy.
