# Path
export PATH="$HOME/.local/bin:$PATH"

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Default editor
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim

setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep

bindkey -v
bindkey '^R' history-incremental-pattern-search-backward

zstyle :compinstall filename '/home/trautwein/.zshrc'

# Autocompletion
autoload -Uz compinit
compinit
kitty + complete setup zsh | source /dev/stdin

# Plugins
source <(antibody init)
antibody bundle < ~/.zsh_plugins

# Aliases
source ~/.zsh_aliases

# Prompt
autoload -Uz promptinit
promptinit

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# autojump
source /etc/profile.d/autojump.sh

# sway
if [ "$(tty)" = "/dev/tty1" ]; then
  exec sway
fi
