###
# History
###

HISTSIZE=10000000
SAVEHIST=10000000
export HISTFILE="${XDG_DATA_HOME:-#HOME/.local/share}/history"

[[ -f "$ZDOTDIR/.workprofile" ]] && . "$ZDOTDIR/.workprofile"

###
# Prompt
###

# Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info
# Enable substitution in the prompt.
setopt prompt_subst
# Run vcs_info just before a prompt is displayed (precmd)
add-zsh-hook precmd vcs_info
# Only display short path in prompt.
PROMPT='%(5~|%-1~/…/%3~|%4~) %F{blue}${vcs_info_msg_0_}%f %# '

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

# Activate zsh completion system.
autoload -Uz +X compinit && compinit
zmodload zsh/zpty

# Make completion menues nicer.
zstyle ':completion:*' menu select
zmodload zsh/complist

# Use vim keys in tab complete menu.
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Enable vi mode.
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e.
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

###
# Source plugins
###

# Autojump (zsh-z) config.
export _Z_CMD="j"
export _Z_DATA=${XDG_DATA_HOME:-$HOME/.local/share}/z

function zsh_source_file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For plugins
        zsh_source_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        zsh_source_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}

zsh_add_plugin "agkozak/zsh-z"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

 [[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

###
# Functions
###

# fh - repeat history
fh() {
	print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

# fkill - kill processes (list only the ones you can kill).
# usage: fkill <pid>
fkill() {
	local pid
	if [ "$UID" != "0" ]; then
		pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
	else
		pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
	fi

	if [ "x$pid" != "x" ]; then
		echo $pid | xargs kill -${1:-9}
	fi
}

# Get the PID of port.
# usage: portpid <port>
portpid() {
	lsof -n -i :$1 | grep LISTEN | awk -F' ' '{print $2}'
}

# fbr - checkout git branch, sorted by most recent commit, limit 30 last branches
fbr() {
	local branches branch
	branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
		branch=$(echo "$branches" |
			fzf-tmux -d $((2 + $(wc -l <<<"$branches"))) +m) &&
		git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# mkcd - mkdir and cd into new directory
# usage: mkcd ./path1/path2/path3
mkcd () {
  mkdir -p $1 && cd $1
}

fzcd() {
	dir="$(rg --hidden --files --null -g '!.git' $HOME/.dotfiles $HOME/Work $HOME/Downloads $HOME/Documents $HOME/Pictures $HOME/.local/share/scripts | xargs -0 dirname | sort | uniq | fzf)"
	cd "$dir"
}

fze() {
	filename="$(rg --hidden --files -g '!.git' $HOME/.dotfiles $HOME/Work $HOME/Downloads $HOME/Documents $HOME/Pictures $HOME/.local/share/scripts | sort | uniq | fzf)"
	$EDITOR "$filename"
}

vimbegood() {
    docker run -it --rm brandoncc/vim-be-good:latest
}

###
# Aliases
###
alias hx="helix"
alias lg="lazygit"
alias ls="exa"
alias emacs="emacsclient -c -a \"\""

###
# FZF
###
#
if [[ ! "$PATH" == */home/j/.dotfiles/vim/.config/vim/plugged/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/j/.dotfiles/vim/.config/vim/plugged/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/j/.dotfiles/vim/.config/vim/plugged/fzf/shell/completion.zsh" 2> /dev/null

###
# X11
###

lockscreen() {
	# https://github.com/google/xsecurelock
	xset s activate
}
