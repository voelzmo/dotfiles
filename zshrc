# Initialize homebrew: sets HOMEBREW_PREFIX, PATH, MANPATH and adds the homebrew zsh completions to FPATH.
# This needs to be above compinit below.
# $HOMEBREW_PREFIX is used instead of calling 'brew --prefix' repeatedly, as each call spawns a ruby process.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# --- shell options (formerly provided by oh-my-zsh) ---

# history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history hist_expire_dups_first hist_ignore_dups hist_ignore_space hist_verify share_history
# show timestamps in yyyy-mm-dd format
alias history='fc -li 1'

# directories
setopt auto_cd auto_pushd pushd_ignore_dups pushdminus
alias -g ...='../..'
alias -g ....='../../..'
alias -- -='cd -'
alias md='mkdir -p'

# emacs key bindings, up/down arrow search history by prefix, ctrl+arrows move by word
bindkey -e
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

alias ls='ls --color=auto'

# --- completion ---

# completion menu, case- and hyphen-insensitive matching
setopt auto_menu complete_in_word always_to_end
unsetopt menu_complete flowcontrol
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$HOME/.cache/zsh"

# the omz kubectl plugin (see zsh_plugins.txt) writes its completion file into $ZSH_CACHE_DIR/completions
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
mkdir -p "$ZSH_CACHE_DIR/completions"
fpath=("$ZSH_CACHE_DIR/completions" $fpath)

# compinit needs to run before antidote loads the plugins, as some of them call 'compdef'
autoload -Uz compinit
compinit

# User configuration

#export PATH="/usr/local/kubebuilder/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/sbin:$PATH"

# export MANPATH="/usr/local/man:$MANPATH"
export PATH="$PATH:$HOME/go/bin"

# Use GNU binaries instead of macos builtins (e.g. sed, base64)
export PATH=$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH
export PATH=$HOMEBREW_PREFIX/opt/grep/libexec/gnubin:$PATH
export PATH=$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH
export PATH=$HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin:$PATH

# OpenVPN needed for gardener
export PATH=$HOMEBREW_PREFIX/opt/openvpn/sbin:$PATH

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

# gron converts json into greppable pieces. 'ungron' can convert it back
alias ungron="gron --ungron"


# enable direnv, which auto-loads .envrc files
eval "$(direnv hook zsh)"

# mise manages tool versions (e.g. ruby, see ~/.config/mise/config.toml)
eval "$(mise activate zsh)"

# source antidote
source $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# kubectl krew as a plugin manager
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# gcloud installation via homebrew
source "$HOMEBREW_PREFIX/share/google-cloud-sdk/path.zsh.inc"
source "$HOMEBREW_PREFIX/share/google-cloud-sdk/completion.zsh.inc"
# check which python version the gcloud formula currently needs and adapt if necessary https://github.com/Homebrew/homebrew-cask/blob/1c59ea3b3b951c58f495dd07a99d4280ea709a12/Casks/g/google-cloud-sdk.rb#L19C2-L19C36
export CLOUDSDK_PYTHON="$HOMEBREW_PREFIX/Frameworks/Python.framework/Versions/Current/bin/python3"

# always have a GCTL_SESSION_ID defined, gardenctl-v2 depends on it
[ -n "$GCTL_SESSION_ID" ] || [ -n "$TERM_SESSION_ID" ] || export GCTL_SESSION_ID=$(uuidgen)

export PATH="$HOMEBREW_PREFIX/opt/openssl@1.1/bin:$PATH"

# put homebrew python and pip on the path
export PATH="$HOMEBREW_PREFIX/opt/python/libexec/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Turn homebrew analytics off
export HOMEBREW_NO_ANALYTICS=1

# starship prompt, configured in ~/.config/starship.toml. Keep this last.
(( $+commands[starship] )) && eval "$(starship init zsh)"
