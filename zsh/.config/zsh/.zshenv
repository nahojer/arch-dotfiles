#!/bin/zsh

# profile file. Runs on login. Environmental variables are set here.

unsetopt PROMPT_SP

# Default programs:
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="wezterm"
export BROWSER="chromium"

# $HOME cleanup:
#Config
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export INPUTRC="$XDG_CONFIG_HOME/shell/inputrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export CONDARC="$XDG_CONFIG_HOME/conda/condarc"
export GIMP2_DIRECTORY="$XDG_CONFIG_HOME/gimp"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export LESSHISTFILE="$XDG_CONFIG_HOME/less/lesshst"
export LESSKEY="$XDG_CONFIG_HOME/less/keys"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
#Data
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GEM_HOME="$XDG_DATA_HOME/gem"
#Cache
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
#Runtime
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Conda
export CONDA_ROOT=/opt/conda
export CONDA_ENVS_PATH=/opt/conda/envs
export CONDA_PKGS_DIRS=/opt/conda/pkgs

# Vim
export MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"

# xsecurelock
export XSECURELOCK_NO_COMPOSITE=1 # Prevent "INCOMPATIBLE COMPOSITOR, PLEASE FIX!" to be displayed.

# Rust
[[ -f "$HOME/.local/share/cargo/env" ]] && . "$HOME/.local/share/cargo/env"

# PATH:
export PATH="$PATH:/usr/bin"
export PATH="$PATH:${XDG_DATA_HOME:-$HOME/.local/share}/go/bin"
export PATH="$PATH:${XDG_DATA_HOME:-$HOME/.local/share}/zig/bin"
export PATH="$PATH:${XDG_DATA_HOME:-$HOME/.local/share}/zls/bin"
export PATH="$PATH:${XDG_DATA_HOME:-$HOME/.local/share}/zlz/bin"
export PATH="$PATH:${XDG_DATA_HOME:-$HOME/.local/share}/cargo/bin"
export PATH="$PATH:${XDG_DATA_HOME:-$HOME/.local/share}/scripts"
export PATH="$PATH:${XDG_CONFIG_HOME:-$HOME/.config}/qutebrowser/userscripts"
export PATH="$PATH:$HOME/.local/bin"
