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
source "$HOME/.kubernetes.zsh"


# nvm
source /usr/share/nvm/init-nvm.sh

# zoxide
eval "$(zoxide init zsh)"

# cargo 
. "$HOME/.cargo/env" 

path+=('/home/arya/go/bin')
path+=('/opt/cuda/bin')

alias countf='find . -name "*.go" -type f'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



# bun completions
[ -s "/home/arya/.bun/_bun" ] && source "/home/arya/.bun/_bun"

# github

alias ghl='gh run list'
alias ghw='gh run watch'
alias ghrr='gh workflow run release'
alias mountnfs='sudo mount -t nfs 192.168.1.34:/mnt/critical /mnt/critical && sudo mount -t nfs 192.168.1.34:/mnt/mass /mnt/mass'

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/home/arya/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
