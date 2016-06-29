# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="miloshadzic"

# Aliases
if [ -f ~/.zshrc.aliases ]; then
  source ~/.zshrc.aliases
fi

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH=/usr/local/sbin:/usr/local/bin:$PATH
export PATH="/usr/local/heroku/bin:$PATH"
export ZSH_TMUX_AUTOSTART=true

# PRIVATE ENV VARS
if [ -f ~/.zshrc.env ]; then
  source ~/.zshrc.env
fi

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew osx rbenv tmux)

source $ZSH/oh-my-zsh.sh
unsetopt correct_all

# Customize to your needs...
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

unalias run-help &>/dev/null
autoload run-help
autoload zmv
HELPDIR=/usr/local/share/zsh/help
