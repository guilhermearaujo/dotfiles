export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH="$(getconf PATH)"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH="/usr/local/opt/flutter/bin:$PATH"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"

export LIBRARY_PATH="/usr/local/opt/openssl/lib/"

export GPG_TTY="$(tty)"

# oh-my-zsh configuration
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="norm" # See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
HIST_STAMPS="dd-mm-yyyy"

export UPDATE_ZSH_DAYS=1

plugins=(bundler brew git rails)

# User configuration
export EDITOR="nano"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
source $HOME/.extra
source $HOME/.keybindings
source $HOME/.secrets

eval "$(nodenv init -)"
eval "$(pyenv init -)"
eval "$(rbenv init -)"
