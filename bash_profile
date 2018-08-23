if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# disable homebrew analytics https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md#opting-out
export HOMEBREW_NO_ANALYTICS=1

# prefer /usr/local before others. homebrew installs things in there. otherwise e.g. git would clash
export PATH="/usr/local/bin:$PATH"

# homebrew installs some apps into /usr/local/sbin, e.g. openvpn
export PATH="/usr/local/sbin:$PATH"

# enable coloring in Terminal
source ~/.bash_prompt

# set git-duet to operate on global gitconfig
export GIT_DUET_GLOBAL=true
# set git-duet to rotate between author and committer after each commit
export GIT_DUET_ROTATE_AUTHOR=1
# use a Co-authored-by trailer rather than a Signed-off-by trailer
export GIT_DUET_CO_AUTHORED_BY=1
# is also implicitly set by GIT_DUET_CO_AUTHORED_BY
export GIT_DUET_SET_GIT_USER_CONFIG=1
# override the default value addIfDifferentNeighbor to avoid duplicate Co-authored-by trailers
git config --global trailer.ifexists addIfDifferent

# Load direnv, to switch gopath based on .direnv files in the current dir
eval "$(direnv hook $0)"

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin

# make nvm installed by homebrew work.
export NVM_DIR=~/.nvm # Create this or you'll see an ugly error message when sourcing this!
source /usr/local/opt/nvm/nvm.sh

# load 'proxy' shell command to set/unset corporate proxy
source ~/.bash_command_proxy

# have rvm at the last place, so it doesn't complain about the order in PATH on every call
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# NOTE: If you're using bosh cli plugins (such as bosh-workspace) you should comment this line. Plugins don't work with BOSH_USE_BUNDLER!
export BOSH_USE_BUNDLER=true

export GOCPI=~/workspace/bosh-openstack-cpi-release/
export GODEV=~/workspace/bosh-openstack-cpi-dev-ci/
export GOEXT=~/workspace/bosh-openstack-cpi-shared/
export GOBOSH=~/workspace/bosh/
export GOSTUFF=~/workspace/stuff/
export GOBATS=~/workspace/bosh-acceptance-tests/
export GODOTS=~/workspace/dotfiles/
export GOVALI=~/workspace/cf-openstack-validator/
export GOCLI=~/go/src/github.com/cloudfoundry/bosh-cli
alias ll='ls -la'
alias gocpi='cd $GOCPI'
alias godev='cd $GODEV'
alias goext='cd $GOEXT'
alias gobosh='cd $GOBOSH'
alias gostuff='cd $GOSTUFF'
alias gobats='cd $GOBATS'
alias godots='cd $GODOTS'
alias govali='cd $GOVALI'
alias gocli='cd $GOCLI'
alias tmate-info="tmate display -p '#{tmate_ssh}'"

export LC_ALL=en_US.UTF-8
export PKG_CONFIG_PATH=$(brew --prefix openssl)/lib/pkgconfig

export HISTCONTROL=ignoredups
export HISTIGNORE="$HISTIGNORE:ls:cd"
export HISTSIZE=950000                             # number of commands to remember in history
export HISTFILESIZE=950000                         # number of lines in history file
export PROMPT_COMMAND="history -a;$PROMPT_COMMAND" # always save history after every command

_bosh() {
        # All arguments except the first one
        args=("${COMP_WORDS[@]:1:$COMP_CWORD}")

        # Only split on newlines
        local IFS=$'\n'
        # Call completion (note that the first element of COMP_WORDS is
        # the executable itself)
        COMPREPLY=($(GO_FLAGS_COMPLETION=1 ${COMP_WORDS[0]} "${args[@]}"))
        return 1
}

complete -o default -F _bosh bosh
alias vi=nvim
alias vim=nvim
export EDITOR=nvim
export VISTYLE=light

eval "$(fasd --init auto)"
alias v='f -e nvim'
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH=$(brew --prefix openvpn)/sbin:$PATH

# logout from lpass after 8 hours
export LPASS_AGENT_TIMEOUT=28800
