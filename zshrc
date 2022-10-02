export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH="$(getconf PATH)"

export GPG_TTY="$(tty)"

# oh-my-zsh configuration
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="norm"
HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
HIST_STAMPS="dd.mm.yyyy"

zstyle ':omz:update' frequency 1
zstyle ':omz:update' mode auto

plugins=(asdf git)

# User configuration
export EDITOR="nano"

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
source $HOME/.extra
source $HOME/.secrets

eval "$(direnv hook zsh)"
