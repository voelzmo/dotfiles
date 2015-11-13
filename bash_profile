if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# prefer /usr/local before others. homebrew installs things in there. otherwise e.g. git would clash
export PATH="/usr/local/bin:$PATH"

# enable coloring in Terminal
source ~/.bash_prompt

# set git-duet to operate on global gitconfig
export GIT_DUET_GLOBAL=true
# set git-duet to rotate between author and committer after each commit
export GIT_DUET_ROTATE_AUTHOR=1

# Load direnv, to switch gopath based on .direnv files in the current dir
eval "$(direnv hook $0)" 

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin

# make nvm installed by homebrew work. 
export NVM_DIR=~/.nvm # Create this or you'll see an ugly error message when sourcing this!
source $(brew --prefix nvm)/nvm.sh

# load 'proxy' shell command to set/unset corporate proxy
source ~/.bash_command_proxy

# have rvm at the last place, so it doesn't complain about the order in PATH on every call
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export BOSH_USE_BUNDLER=true
