#!/bin/bash

# Sets up most of my tools on Mac
# Other things to install:
#   - Xcode + Command Line Utilities

echo "Installing brew"
/bin/bash -c $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)

echo "Installing brew cask"
brew tap homebrew/cask

echo "Installing developer tools"
brew install --HEAD neovim
brew install docker
brew install git
brew install --cask github
brew install --cask postman

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
brew install fzf

echo "Installing fonts"
brew tap homebrew/cask-fonts
brew install font-anonymous-pro
brew install font-ibm-plex-mono
brew install font-fira-code-nerd-font
brew install font-input
brew install font-iosevka

echo "Installing programming languages and version managers"
brew install nvm
brew install pyenv

echo "Installing communication tools"
brew install --cask slack
brew install --cask zoom

echo "Installing other tools"
brew install --cask firefox
brew install --cask alfred
brew install --cask hiddenbar
brew install --cask spotify

echo "Setting up oh-my-zsh"
/bin/bash -c $(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)
cp $HOME/.zshrc.pre-oh-my-zsh $HOME/.zshrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
source $HOME/.zshrc

echo "Pulling in dotfiles"
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/marquessv/.dotfiles.git tmpdotfiles
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
rm -r tmpdotfiles
dotfiles config --local status.showUntrackedFiles no
dotfiles remote add origin git@github.com:marquessv/.dotfiles.git

