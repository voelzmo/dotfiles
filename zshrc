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

# vi key bindings: start in insert mode, <Esc> switches to command mode (starship shows the mode in the prompt).
# This needs to stay above the other bindkey lines, as plain 'bindkey' binds into the active keymap.
bindkey -v
# only wait 10ms after <Esc> instead of the default 400ms
KEYTIMEOUT=1

# up/down arrows search history by the prefix typed so far, ctrl+arrows move by word
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
for keymap in viins vicmd; do
  bindkey -M $keymap '^[[A' up-line-or-beginning-search
  bindkey -M $keymap '^[[B' down-line-or-beginning-search
  bindkey -M $keymap '^[[1;5C' forward-word
  bindkey -M $keymap '^[[1;5D' backward-word
done

# 'v' in command mode edits the current command line in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

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

# fzf: fuzzy finder with ctrl+r (history), ctrl+t (files), alt+c (cd) and ** tab completion.
# This needs to be after compinit and the vi bindings above, as it binds into both vi keymaps and replaces ctrl+r.
# '--color=light' is the base scheme for light terminal themes (solarized light).
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border --color=light"

# fd is a faster 'find' that respects .gitignore. Use it for ctrl+t, alt+c and ** completion.
# FZF_CTRL_T_COMMAND/FZF_ALT_C_COMMAND are only set if fd exists, an empty value would disable the key binding.
if (( $+commands[fd] )); then
  export FZF_CTRL_T_COMMAND="fd --type f --type d --hidden --follow --exclude .git"
  export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
  _fzf_compgen_path() { fd --hidden --follow --exclude .git . "$1" }
  _fzf_compgen_dir() { fd --type d --hidden --follow --exclude .git . "$1" }
fi

# bat is a 'cat' with syntax highlighting, used for the file preview of ctrl+t.
if (( $+commands[bat] )); then
  export BAT_THEME="Solarized (light)"
  export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :200 {}'"
fi
# alt+c previews the directory content
export FZF_ALT_C_OPTS="--preview 'ls -1A --color=always {}'"

(( $+commands[fzf] )) && source <(fzf --zsh)
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

# gardenctl shortcuts (g, gtv, gk, gp, ...), completion and GCTL_SESSION_ID, which gardenctl-v2 depends on.
# Must come after compinit.
(( $+commands[gardenctl] )) && source <(gardenctl rc zsh)

export PATH="$HOMEBREW_PREFIX/opt/openssl@1.1/bin:$PATH"

# put homebrew python and pip on the path
export PATH="$HOMEBREW_PREFIX/opt/python/libexec/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Turn homebrew analytics off
export HOMEBREW_NO_ANALYTICS=1

# starship prompt, configured in ~/.config/starship.toml. Keep this last.
(( $+commands[starship] )) && eval "$(starship init zsh)"
