export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH="$(getconf PATH)"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export LIBRARY_PATH="/usr/local/opt/openssl/lib/"

export GPG_TTY="$(tty)"

# oh-my-zsh configuration
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
HIST_STAMPS="dd-mm-yyyy"

export UPDATE_ZSH_DAYS=1

plugins=(bundler brew git iterm2 rails)

unsetopt nomatch

# User configuration
export EDITOR="nano"

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
source $HOME/.extra
source $HOME/.keybindings
source $HOME/.secrets

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(direnv hook zsh)"
eval "$(nodenv init -)"
eval "$(pyenv init -)"
eval "$(rbenv init -)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
