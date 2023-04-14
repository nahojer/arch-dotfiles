#!/bin/bash

outdir="$HOME/.dotfiles/system-info"
mkdir -p "$outdir"

function append() {
  cat /dev/stdin
  $*
}

function format() {
  cat < /dev/stdin | sort | uniq | sed '/^$/d'
}

# Installed cargo packages.
ls -l "$CARGO_HOME/bin" | awk '{print $9}' | format > "$outdir/cargo.txt"

# Installed pacman packages.
pacman -Qe | append pacman -Qm | awk '{print $1}' | format > "$outdir/pacman.txt"

# Enabled systemd services.
systemctl list-unit-files --state=enabled \
  | awk '{print $1}' \
  | awk 'BEGIN{FILTER="\\.(service|timer|socket|path|device|mount|automount|swap|target|snapshot|slice|scope)$"} tolower($NF) ~ FILTER { print $NF }' \
  | format > "$outdir/systemd.txt"

# Globally installed NPM packages.
#npm list -g | awk '{print $2}' | format > "$outdir/npm.txt"

# Globally installed Go packages.
ls $GOPATH/bin | awk '{print $1}' | format > "$outdir/go.txt"
