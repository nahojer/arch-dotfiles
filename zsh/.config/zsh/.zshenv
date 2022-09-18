#!/bin/zsh

# profile file. Runs on login. Environmental variables are set here.

unsetopt PROMPT_SP

# Default programs:
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export CM_LAUNCHER="rofi"

# $HOME cleanup:
#Config
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
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
#Data
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export HISTFILE="$XDG_DATA_HOME/history"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GEM_HOME="$XDG_DATA_HOME/gem"
#Cache
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
#Runtime
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"

# Conda
export CONDA_ROOT=/opt/conda
export CONDA_ENVS_PATH=/opt/conda/envs
export CONDA_PKGS_DIRS=/opt/conda/pkgs

# Other program settings:
export MOZ_USE_XINPUT2="1" # Mozilla smooth scrolling/touchpads.

# PATH:
export PATH="$PATH:${$(find $HOME/.local/bin -type d -printf %p:)%%:}" # Adds `~/.local/bin` to $PATH
export PATH="$PATH:${XDG_DATA_HOME:-$HOME/.local/share}/go/bin"
export PATH="$PATH:${XDG_DATA_HOME:-$HOME/.local/share}/scripts"
export PATH="$PATH:$HOME/.local/bin"

# Rust
. "/home/j/.local/share/cargo/env"
