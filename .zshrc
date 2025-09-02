typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZINIT

if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


# p10k

zinit ice depth=1; zinit light romkatv/powerlevel10k

# plugins

zinit light zsh-users/zsh-syntax-highlighting

zinit light zsh-users/zsh-completions

zinit light zsh-users/zsh-autosuggestions

zinit light Aloxaf/fzf-tab

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::kubectl
zinit snippet OMZP::command-not-found

autoload -U compinit && compinit
zinit cdreplay -q
# history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups


zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':completion:*' menu no

# ls

alias ls='eza'

# neovim
alias vim='nvim'

# nvim editor
export EDITOR='nvim'

# fzf

eval "$(fzf --zsh)"

# cd

alias cd='z'

# kubenetes aliases
alias k='kubecolor'
alias kgp='kubecolor get pods'
alias kgpw='kubecolor get pods -o wide'
alias kgpww='kubecolor get pods -o wide --watch'
alias ke='kubecolor get events'
alias kn='kubecolor config set-context --current --namespace'
alias kew='kubecolor get events --watch'
source <(kubectl completion zsh)
compdef kubecolor=kubectl


# nvm
#
source /usr/share/nvm/init-nvm.sh

# zoxide
eval "$(zoxide init zsh)"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# github

alias mountnfs='sudo mount -t nfs 192.168.1.34:/mnt/critical /mnt/critical && sudo mount -t nfs 192.168.1.34:/mnt/mass /mnt/mass'


alias ..='cd ..'


open() {
    command xdg-open "$@" >/dev/null 2>&1 &!
}

path+=('/opt/kustomize/viaduct.ai/v1/ksops')

source .fun.zsh

