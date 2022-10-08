# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export GPG_TTY="$(tty)"

# oh-my-zsh configuration
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
