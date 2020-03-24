export TERM="xterm-256color"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export ZSH="$HOME/.oh-my-zsh"

POWERLEVEL9K_MODE='nerdfont-complete'
ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs newline)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(docker-compose web-search rails git zsh-syntax-highlighting zsh-autosuggestions bundler history-substring-search)

source "$ZSH/oh-my-zsh.sh"
source "$HOME/.zshrc_local"
export EDITOR='nvim'

# RBENV
eval "$(rbenv init -)"

# Z
[ -f $(brew --prefix)/etc/profile.d/z.sh ] && source $(brew --prefix)/etc/profile.d/z.sh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:~/Library/Python/2.7/bin:~/Library/Python/3.7/bin

alias kc=kubectl
alias kcget='kubectl get deployment,svc,pods,pvc'

gbc() {
    git checkout $(git branch | grep $1)
}

pullrequest() {
    local ISSUE=$1
    local ISSUE_LOWER=$(echo $1 | awk '{print tolower($0)}')
    local ISSUE_UPPER=$(echo $1 | awk '{print toupper($0)}')
    shift
    if [[ $1 -eq "--no-open" ]] ; then
        local NOOPEN=true
    fi

    local SUMMARY=$(curl \
        -u $JIRA_USER:$JIRA_TOKEN \
        -X GET \
        -H "Content-Type: application/json" \
        https://nerdgeschoss.atlassian.net/rest/api/latest/issue/$ISSUE \
        | jq .fields.summary \
        | sed 's/^"//' \
        | sed 's/"$//')

    local SUMMARY_SANITIZED=$(echo $SUMMARY \
        | sed 's/[^a-zA-Z]/_/g' \
        | sed -E 's/_{2,}/_/g' \
        | sed 's/^_//' \
        | sed 's/_$//' \
        | awk '{print tolower($0)}')

    git checkout -b "feature/$ISSUE_LOWER_$SUMMARY_SANITIZED"
    git commit --allow-empty -m "$ISSUE_UPPER: $SUMMARY" -m "initial commit [ci skip]"
    git push origin HEAD

    local PR=$(hub pull-request -F- <<<"$ISSUE_UPPER: $SUMMARY

    https://nerdgeschoss.atlassian.net/browse/$ISSUE_UPPER")

    open $PR
}

gacm() {
    git add . && git commit -m "$*"
}

delete_branches() {
    git branch | grep -v "master" >/tmp/merged-branches && vi /tmp/merged-branches && xargs git branch -D </tmp/merged-branches
}

kcbash() {
    kubectl exec -it $1 bash
}

kclogs() {
    kubectl logs -f $1
}

cheat() {
    curl cheat.sh/$1
}

dstop() {
    docker stop $(docker ps -aq)
}

request_review() {
    # if [[ $# -eq 0 ]] ; then
    #     local REVIEWERS="[\"Adeynack\",\"JensRavens\"]"
    # else
    #     # Create JSON array from args
    #     local REVIEWERS="\"$1\""
    #     shift

    #     while (( $# )); do
    #         local REVIEWERS="$REVIEWERS, \"$1\""
    #         shift
    #     done

    #     local REVIEWERS="[$REVIEWERS]"
    # fi

    local REMOTE=$(git remote -v | grep origin | head -n 1)
    local PATTERN='.+git@github.com:([a-zA-Z0-9]+)\/([a-zA-Z0-9]+)\.git.*'

    [[ $REMOTE =~ $PATTERN ]]

    local ORGANIZATION="$match[1]"
    local REPO="$match[2]"
    local PR_NUMBER=$(hub api "/repos/$ORGANIZATION/$REPO/pulls?head=$ORGANIZATION:$(git rev-parse --abbrev-ref HEAD)" | jq '.[0].number')

    # request reviewers
    # echo "{\"reviewers\": $REVIEWERS}" > /tmp/ng_reviewers.json
    # hub api "/repos/$ORGANIZATION/$REPO/pulls/$PR_NUMBER/requested_reviewers" --input /tmp/ng_reviewers.json > /dev/null && echo "Requested review from $REVIEWERS!"
    # get name of review label
    local LABEL=$(hub api "/repos/$ORGANIZATION/$REPO/labels" | jq '.[] | select(.name | contains("review") or contains("Review")) | .name')
    # add label
    echo "{\"labels\": [$LABEL]}" > /tmp/ng_label.json
    hub api "/repos/$ORGANIZATION/$REPO/issues/$PR_NUMBER/labels" --input /tmp/ng_label.json > /dev/null && echo "Added Review Label!"

    # Stop running timer
    local RUNNING_TIMER_ID=$(curl --silent \
      -H "Harvest-Account-ID: $HARVEST_ACCOUNT_ID"\
      -H "Authorization: Bearer $HARVEST_API_KEY" \
      "https://api.harvestapp.com/api/v2/time_entries?is_running=true" | jq '.time_entries[0].id')

    if [ $RUNNING_TIMER_ID != "null" ]; then
        curl --silent "https://api.harvestapp.com/v2/time_entries/$RUNNING_TIMER_ID/stop" \
          -H "Authorization: Bearer $HARVEST_API_KEY" \
          -H "Harvest-Account-Id: $HARVEST_ACCOUNT_ID" \
          -X PATCH
    else
        echo "No timer running. Done!"
    fi
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
# timeout for changing modes in vi
export KEYTIMEOUT=1
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export PATH="/usr/local/opt/openssl/bin:$PATH"

# fixes weird 'gpg: signing failed: Inappropriate ioctl for device'
export GPG_TTY=$(tty)
