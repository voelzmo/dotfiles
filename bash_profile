if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# prefer /usr/local before others. homebrew installs things in there. otherwise e.g. git would clash
export PATH="/usr/local/bin:$PATH"

source ~/.proxy

# enable coloring in Terminal
source ~/.bash_prompt

# set git-duet to operate on global gitconfig
export GIT_DUET_GLOBAL=true

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Load direnv, to switch gopath based on .direnv files in the current dir
eval "$(direnv hook $0)" 

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin

# make nvm installed by homebrew work. 
export NVM_DIR=~/.nvm # Create this or you'll see an ugly error message when sourcing this!
source $(brew --prefix nvm)/nvm.sh

