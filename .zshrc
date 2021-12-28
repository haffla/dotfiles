if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload bashcompinit
bashcompinit

export TERM="xterm-256color"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export ZSH="$HOME/.oh-my-zsh"
export UPDATE_ZSH_DAYS=30
export EDITOR='nvim'
# timeout for changing modes in vi
export KEYTIMEOUT=1
# fixes weird 'gpg: signing failed: Inappropriate ioctl for device'
export GPG_TTY=$(tty)

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"

unsetopt correct_all

plugins=(
        docker-compose
        web-search
        rails
        git
        zsh-syntax-highlighting
        zsh-autosuggestions
        bundler
        history-substring-search
        colored-man-pages
        autojump
        colorize
)

source "$ZSH/oh-my-zsh.sh"
source "$HOME/.zshrc_local"
# Colorize with less
alias dps="docker ps"
alias ec="$EDITOR $HOME/.zshrc"
alias sc="source $HOME/.zshrc"
alias con="$EDITOR ~/.config/nvim/init.vim"
alias code="cd ~/code"
alias gpeek=git-peek
alias gl='git log --graph --abbrev-commit --decorate --all --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - \ %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)"'
alias n=nvim
alias c=clear



gacm() {
    git add . && git commit -m "$*"
}

delete_branches() {
    git branch | egrep -v "(master|develop|main)" >/tmp/merged-branches && vi /tmp/merged-branches && xargs git branch -D </tmp/merged-branches
}

cheat() {
    curl cheat.sh/$1
}

dstop() {
    docker stop $(docker ps -aq)
}

# use vi keybindings
bindkey -v
set blink-matching-paren on
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^ ' autosuggest-accept
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

. /usr/local/opt/asdf/libexec/asdf.sh
