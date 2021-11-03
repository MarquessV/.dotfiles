#!/bin/bash

# Sets up most of my tools on Mac
# Other things to install:
#   - Xcode + Command Line Utilities
#   - Amphetamine
#   - Android Studio
#   - Setup nvm, npm, yarn

echo "Installing brew"
$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)

echo "Installing brew cask"
brew tap homebrew/cask

echo "Installing developer tools"
brew install --HEAD neovim
brew install docker
brew install git
brew install openvpn
brew install --cask github
brew install --cask postman
brew install --cask runjs

echo "Installing mobile dev tools"
brew install --cask flipper
brew tap wix/brew
brew install applesimutils
brew install bundletool
brew install openjdk
brew install watchman

echo "Installing command line tools"
brew install --cask kitty
brew install exa
brew install zoxide
brew install direnv
brew install bat
brew install glow
brew install imagemagick
brew install ripgrep
brew install web

echo "Installing fonts"
brew tap homebrew/cask-fonts
brew install font-anonymous-pro
brew install font-ibm-plex-mono
brew install font-fira-code-nerd-font

echo "Installing programming languages and version managers"
brew install nvm
brew install rvm
brew install pyenv

echo "Installing communication tools"
brew install --cask slack
brew install --cask zoom

echo "Installing other tools"
brew install --cask dropbox
brew install --cask firefox
brew install --cask alfred
brew install --cask itsycal
brew install --cask hiddenbar
brew install --cask spotify

echo "Setting up oh-my-zsh"
$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)

echo "Pulling in dotfiles"
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/marquessv/.dotfiles.git tmpdotfiles
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
rm -r tmpdotfiles
