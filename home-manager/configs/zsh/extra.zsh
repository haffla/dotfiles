set blink-matching-paren on

bindkey -v
bindkey '^r' history-incremental-search-backward
bindkey '^ ' autosuggest-accept
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

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

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ ! -f "$(brew --prefix)/opt/asdf/libexec/asdf.sh" ]] || source "$(brew --prefix)/opt/asdf/libexec/asdf.sh"
[[ ! -f "$(brew --prefix nvm)/nvm.sh" ]] || source "$(brew --prefix nvm)/nvm.sh"
[[ ! -f ~/.zshrc_local ]] || source ~/.zshrc_local

if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# TWilio CLI autocomplete
TWILIO_AC_ZSH_SETUP_PATH=~/.twilio-cli/autocomplete/zsh_setup && test -f $TWILIO_AC_ZSH_SETUP_PATH && source $TWILIO_AC_ZSH_SETUP_PATH;
