autoload bashcompinit
bashcompinit

export TERM="xterm-256color"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

POWERLEVEL9K_MODE='nerdfont-complete'
ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs newline)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
export UPDATE_ZSH_DAYS=30
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
        common-aliases
        asdf
        autojump
        colorize
)

source "$ZSH/oh-my-zsh.sh"
source "$HOME/.zshrc_local"
export EDITOR='nvim'
export PATH=$PATH:~/Library/Python/2.7/bin:~/Library/Python/3.7/bin

# Colorize with less
alias cl=cless
alias pulls="hub browse -- pulls"
alias dps="docker ps"
alias ec="$EDITOR $HOME/.zshrc"
alias sc="source $HOME/.zshrc"
alias con="$EDITOR ~/.config/nvim/init.vim"
alias code="cd ~/code"



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
        https://$JIRA_PROJECT.atlassian.net/rest/api/latest/issue/$ISSUE \
        | jq .fields.summary \
        | sed 's/^"//' \
        | sed 's/"$//')

    local SUMMARY_SANITIZED=$(echo $SUMMARY \
        | sed 's/[^a-zA-Z]/_/g' \
        | sed -E 's/_{2,}/_/g' \
        | sed 's/^_//' \
        | sed 's/_$//' \
        | awk '{print tolower($0)}')

    local ISSUE_SNAKE=$(echo $ISSUE_LOWER | sed 's/-/_/g')

    git checkout -b "feature/${ISSUE_SNAKE}_$ISSUE_LOWER_$SUMMARY_SANITIZED" master
    git commit --allow-empty -m "$ISSUE_UPPER: $SUMMARY" -m "initial commit [ci skip]"
    git push origin HEAD

    local PR=$(hub pull-request -F- <<<"$ISSUE_UPPER: $SUMMARY

    https://$JIRA_PROJECT.atlassian.net/browse/$ISSUE_UPPER")

    open $PR
}

gacm() {
    git add . && git commit -m "$*"
}

delete_branches() {
    git branch | grep -v "master" >/tmp/merged-branches && vi /tmp/merged-branches && xargs git branch -D </tmp/merged-branches
}

cheat() {
    curl cheat.sh/$1
}

dstop() {
    docker stop $(docker ps -aq)
}

request_review() {
    # if [[ $# -eq 0 ]] ; then
    #     local REVIEWERS="[\"username1\",\"username2\"]"
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
    echo "{\"labels\": [$LABEL]}" > /tmp/pr_labels.json
    hub api "/repos/$ORGANIZATION/$REPO/issues/$PR_NUMBER/labels" --input /tmp/pr_labels.json > /dev/null && echo "Added Review Label!"

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
# fixes weird 'gpg: signing failed: Inappropriate ioctl for device'
export GPG_TTY=$(tty)
