#!/bin/bash
dotfiles_dir=$HOME/.dotfiles
need_restart=false

if [[ $OSTYPE == darwin* ]]; then

  echo 'Installing dependencies...'
  # Install homebrew if not installed
  if ! type -p brew &>/dev/null; then
    echo 'Homebrew not installed, install homebrew y/n?'
    read install
    if [[ $install == 'y' ]]; then
      echo 'Sudo required for homebrew installation:'
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    else
      echo 'Installation cancelled'
      exit 1
    fi
  fi

  # Install RCM if not installed
  if type -p rcm &>/dev/null; then
    brew update
    brew tap thoughtbot/formulae
    brew install rcm
  fi
# Ubuntu
elif [[ $OSTYPE == linux-gnu* ]]; then
  if ! type -p zsh &>/dev/null; then
    echo 'Installing zsh; interaction will be required...'
    sudo apt-get install zsh
  fi

  echo 'Installing RCM; interaction will be required...'
  # checking for rcup; there's probably a better way to do this...
  if ! type -p rcup &>/dev/null; then
    sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
    sudo apt-get update
    sudo apt-get install rcm
  fi
else
  echo "OS not supported. OSTYPE: ${OSTYPE}"
  exit 1
fi

echo 'Installing Oh My Zsh...'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

if [[ ${SHELL: -3} != "zsh" ]]; then
  echo 'Changing default shell to zsh...'
  chsh -s $(which zsh)
  need_restart=true
fi

echo 'Creating placeholder local files'
local_dir=$dotfiles_dir/local
mkdir -p $local_dir

# local gitconfig
if ! test -f $local_dir/gitconfig; then
  printf "# Add local git config\n# Example:\n# [credential]\n#   helper = <osxkeychain|store>" >> $local_dir/gitconfig
fi

# Local aliases (Usefull to hide any senstive info such as ssh ips/ports/etc.)
if ! test -f $local_dir/aliases; then
  printf "# Add local aliases\n# Example:\n# alias a='echo \"AWESOME\"'" >> $local_dir/aliases
fi

# Local functions
if ! test -f $local_dir/functions; then
  printf "# Add local functions to this file\n" >> $local_dir/functions
fi

echo 'Installing dotfiles...'
RCRC=$dotfiles_dir/rcrc rcup -v

echo 'Installing git hooks for this repo...'
ln -sf $dotfiles_dir/githooks/dotfiles/* $dotfiles_dir/.git/hooks/

echo 'Pre-requisites, dotfiles and hooks installed!'

if [[ $need_restart == true ]]; then
  echo 'Restart shell for changes to take effect.'
fi
