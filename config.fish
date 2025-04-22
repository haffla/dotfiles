set -g -x EDITOR nvim

function gacm
    git add . && git commit -m "$argv"
end

function git_current_branch
    git rev-parse --abbrev-ref HEAD
end

function gch
    git branch | grep -v "^\*" | fzf | read -l branch

    if set -q branch
        set branch (string trim $branch)
        git checkout $branch
    end
end

bind -M insert -k nul accept-autosuggestion
bind -M default -k nul accept-autosuggestion
bind -M insert \cp history-search-backward
bind -M insert \cn history-search-forward
bind -M default \cp history-search-backward
bind -M default \cn history-search-forward

fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line

alias n='nvim'
alias c='clear'

alias gst='git status'
alias gl='git log'
alias gb='git branch'
alias ga='git add'
alias gcm='git checkout main'
alias gcmsg='git commit -m'
alias ggpull='git pull origin $(git_current_branch)'
alias ggpush='git push origin $(git_current_branch)'
alias gco='git checkout'
alias gd='git diff'
alias gstp='git stash pop'
alias gsta='git stash apply'
alias gcp='git cherry-pick'

alias be='bundle exec'
alias r='bin/rails'

set --global hydro_color_git FFB6C1
set --global hydro_color_prompt brgreen

set -U fish_history_max_items 10000

eval "$(/opt/homebrew/bin/brew shellenv)"
status --is-interactive; and rbenv init - --no-rehash fish | source

fish_add_path /Users/jacke/code/tourlane/aws-console/scripts
fish_add_path /Users/jacke/Downloads/llm-term-v.1.2/target/release
# set -U fish_user_paths /Users/jacke/code/tourlane/aws-console/scripts $fish_user_paths

# Created by `pipx` on 2025-04-22 15:36:29
set PATH $PATH /Users/jacke/.local/bin
