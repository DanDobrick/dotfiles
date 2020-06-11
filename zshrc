########################
# Oh-my-zsh
########################

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Custom ZSH folder
ZSH_CUSTOM=$HOME/.zsh/custom

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

########################
# Plugins
########################
plugins=(
    git
    ruby
    osx
    bundler
    autoupdate
    aws
#     zsh-autocomplete
)

source $ZSH/oh-my-zsh.sh

########################
# Aliases
########################
# git
alias gl='git log'
alias gs='git status'
alias ggfetch='gfa'

# General
alias ls='ls -G'
alias ll='ls -lah'
alias e=$EDITOR

# Reload changes to this file
alias sourcezsh='source ~/.zshrc'

alias simple-server='python -m SimpleHTTPServer'

# docker
alias clean-docker-volumes='docker volume rm $(docker volume ls -f dangling=true -q)'
alias dkcmp='docker-compose'

# ruby
alias diespring="pkill -f spring && ps aux | grep spring"

# Local aliases should overwrite
source $HOME/.local/aliases

########################
# History
########################
HISTSIZE=10000000 # Number of entries
SAVEHIST=10000000 # Number of entries
HISTFILE=~/.zsh_history # File
setopt INC_APPEND_HISTORY # Add immediately
setopt HIST_IGNORE_DUPS # Don't show duplicates in search
setopt SHARE_HISTORY # Share history between session/terminals

########################
# p10k
########################
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

########################
# nvm
########################
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

########################
# Misc
########################

# copy ruby hooks to current project's hook dir
function link-ruby-hooks() {
  if [ -d .git ]; then
    git_dir=$(git rev-parse --git-dir)
    ln -sf ~/.dotfiles/githooks/ruby/* $git_dir/hooks/
  else
    git rev-parse --git-dir 2> /dev/null;
  fi;
}

# Update with brew/apt, RVM and NVM
function update() {
  if [[ $OSTYPE == darwin* ]]; then
    echo 'Update brew + apps installed with brew? (y/n)'
    read confirmation
    if [[ $confirmation == 'y' ]]; then
      brew update
      brew upgrade
    fi
  elif [[ $OSTYPE == linux-gnu* ]]; then
    echo 'NOT WORKING AT THIS TIME'
    exit 1
    echo 'Update system? (y/n)'
    read confirmation
    if [[ $confirmation == 'y' ]]; then
      sudo apt-get update
      sudo apt-get upgrade
    fi
  fi

  if type rvm &>/dev/null; then
    echo 'Update rvm? (y/n)'
    read confirmation
    if [[ $confirmation == 'y' ]]; then
      rvm get stable
    fi
  fi

  if type nvm &>/dev/null; then
    echo 'Update nvm? (y/n)'
    read confirmation
    if [[ $confirmation == 'y' ]]; then
      curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
    fi
  fi
}

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  if type -p mine &>/dev/null; then
    export EDITOR='mine'
  elif type -p code &>/dev/null; then
    export EDITOR='code'
  else
    export EDITOR='vim'
  fi
fi

# mkdir + cd
function mkcd() {
  mkdir -p "$1" && cd "$1";
}

# color man pages
function man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}
