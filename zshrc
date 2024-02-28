# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 28

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(macos kube-ps1)

# enable homebrew zsh autocompletions. This needs to be above the 'source oh-my-sh' line, as that one calls 'compinit'!
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

source $ZSH/oh-my-zsh.sh

# User configuration

# set kube-ps1 prompt
PROMPT='$(kube_ps1)'$PROMPT

#export PATH="/usr/local/kubebuilder/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/sbin:$PATH"

# export MANPATH="/usr/local/man:$MANPATH"
export PATH="$PATH:$HOME/go/bin"

# Use GNU binaries instead of macos builtins (e.g. sed, base64)
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
export PATH=$(brew --prefix grep)/libexec/gnubin:$PATH
export PATH=$(brew --prefix gnu-sed)/libexec/gnubin:$PATH
export PATH=$(brew --prefix gnu-tar)/libexec/gnubin:$PATH

# OpenVPN needed for gardener
export PATH=$(brew --prefix openvpn)/sbin:$PATH

# GOPATH is needed for 'make generate' in gardener
export GOPATH=$HOME/go

# Make kubectl use the gke-cloud-auth-plugin instead of default provider-specific code according to https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias k=kubectl

# gron converts json into greppable pieces. 'ungron' can convert it back
alias ungron="gron --ungron"


# enable direnv, which auto-loads .envrc files
eval "$(direnv hook zsh)"

# source antidote
source $(brew --prefix antidote)/share/antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# kubectl krew as a plugin manager
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# gcloud installation via homebrew
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
# check which python version the gcloud formula currently needs and adapt if necessary https://github.com/Homebrew/homebrew-cask/blob/1c59ea3b3b951c58f495dd07a99d4280ea709a12/Casks/g/google-cloud-sdk.rb#L19C2-L19C36
export CLOUDSDK_PYTHON="$(brew --prefix python@3.11)/bin/python3.11"

# always have a GCTL_SESSION_ID defined, gardenctl-v2 depends on it
[ -n "$GCTL_SESSION_ID" ] || [ -n "$TERM_SESSION_ID" ] || export GCTL_SESSION_ID=$(uuidgen)

export PATH="$(brew --prefix openssl@1.1)/bin:$PATH"

# put homebrew python and pip on the path
export PATH="$(brew --prefix python)/libexec/bin:$PATH"
