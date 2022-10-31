# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH="$(getconf PATH)"
export PATH="/usr/local/bin:$PATH"

export GPG_TTY="$(tty)"

# oh-my-zsh configuration
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
HYPHEN_INSENSITIVE="true"
HIST_STAMPS="dd.mm.yyyy"

zstyle ':omz:update' frequency 1
zstyle ':omz:update' mode auto

plugins=(brew asdf direnv git)

unsetopt nomatch
setopt HIST_IGNORE_SPACE

export EDITOR="nano"
export WORKSPACE="$HOME/Workspace"

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
source $HOME/.extra
source $HOME/.keybindings
source $HOME/.secrets

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
compinit

source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL="true"
export GRPC_PYTHON_BUILD_SYSTEM_ZLIB="true"
export CFLAGS="-I$(brew --prefix openssl@3)/include"
export LDFLAGS="-L$(brew --prefix openssl@3)/lib"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
