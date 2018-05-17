#!/bin/bash

########## Variables

DIR=~/dotfiles                    # dotfiles directory
OLDDIR=~/dotfiles_old             # backup directory
SETUPFILE=setup.sh                # the filename of this script
READMEFILE=README.md              # readme file

COLOR_NORMAL=$(tput sgr0)
COLOR_CODE=$(tput setaf 4)
COLOR_SUCCESS=$(tput setaf 2)

SUCCESS="${COLOR_SUCCESS}┌───────────────────────┐\n│         Done!         │\n└───────────────────────┘${COLOR_NORMAL}\n\n"

########## Dotfiles backup and symlinking
printf "${COLOR_NORMAL}Backing up any existing dotfiles to ${COLOR_CODE}${OLDDIR}${COLOR_NORMAL} and linking the ones from ${COLOR_CODE}${DIR}${COLOR_NORMAL}...\n"

cd $DIR

mkdir -p $OLDDIR/config
for FILE in $DIR/config/*; do
  FILENAME=$(basename "${FILE}")
  printf "${FILENAME}\n"
  cp ~/.${FILENAME} ${OLDDIR}/${FILENAME} &>/dev/null
  rm ~/.${FILENAME} &>/dev/null

  ln -s ${FILE} ~/.${FILENAME}
done

mkdir -p $OLDDIR/nvim
mkdir -p ~/.config/nvim
for FILE in $DIR/nvim/*; do
  FILENAME=$(basename "${FILE}")
  printf ".config/nvim/${FILENAME}\n"
  cp ~/.config/nvim/${FILENAME} ${OLDDIR}/nvim/${FILENAME} &>/dev/null
  rm ~/.config/nvim/${FILENAME} &>/dev/null

  ln -s ${FILE} ~/.config/nvim/${FILENAME}
done

mkdir -p $OLDDIR/tmuxinator
mkdir -p ~/.config/tmuxinator
for FILE in $DIR/tmuxinator/*; do
  FILENAME=$(basename "${FILE}")
  printf ".config/tmuxinator/${FILENAME}\n"
  cp ~/.config/tmuxinator/${FILENAME} ${OLDDIR}/tmuxinator/${FILENAME} &>/dev/null
  rm ~/.config/tmuxinator/${FILENAME} &>/dev/null

  ln -s ${FILE} ~/.config/tmuxinator/${FILENAME}
done

touch ~/.zshrc.aliases ~/.zshrc.env

printf "${SUCCESS}"

########## Install and setup homebrew and packages
printf "Installing ${COLOR_CODE}homebrew${COLOR_NORMAL} if it's not present...\n"

if [ ! -f /usr/local/bin/brew ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

printf "${SUCCESS}"

printf "Setting up ${COLOR_CODE}homebrew${COLOR_NORMAL}...\n"

brew update
brew doctor
brew upgrade

printf "${SUCCESS}"

printf "Installing essential ${COLOR_CODE}homebrew${COLOR_NORMAL} packages...\n"

brew install archey
brew install asciinema
brew install autoconf
brew install coreutils
brew install ffmpeg
brew install gist
brew install git
brew install gitup
brew install htop
brew install iftop
brew install imagemagick
brew install librsvg
brew install libxml2 libxslt
brew install mas
brew install neovim
brew install nmap
brew install npm
brew install optipng
brew install progress
brew install rbenv
brew install reattach-to-user-namespace
brew install ripgrep
brew install ruby-build
brew install the_silver_searcher
brew install tig
brew install tmux
brew install tokei
brew install tree
brew install weechat
brew install wget
brew install yarn
brew install youtube-dl
brew install zsh

brew tap getantibody/homebrew-antibody
brew install antibody

printf "${SUCCESS}"

printf "Installing essential ${COLOR_CODE}homebrew cask${COLOR_NORMAL} packages...\n"

brew tap caskroom/cask
brew cask upgrade

brew cask install amethyst
brew cask install dash
brew cask install docker
brew cask install dropbox
brew cask install google-chrome
brew cask install gpg-suite
brew cask install iterm2
brew cask install macdown

brew prune
brew cleanup

printf "${SUCCESS}"

printf "Installing essential ${COLOR_CODE}App Store${COLOR_NORMAL} packages...\n"

mas install 1362171212 # Caffeinated
mas install 1039633667 # Irvue
mas install 904280696  # Things 3

printf "${SUCCESS}"

########## Build and setup ruby
printf "Building the latest ${COLOR_CODE}ruby${COLOR_NORMAL} and setting it as default...\n"

eval "$(rbenv init -)"
LATEST_RUBY_VERSION=$(rbenv install -l | grep -v - | tail -1)
rbenv install $LATEST_RUBY_VERSION
rbenv global $LATEST_RUBY_VERSION

printf "${SUCCESS}"

########## Setup gems
printf "Installing essential ${COLOR_CODE}rubygems${COLOR_NORMAL}...\n"

bundle update

printf "${SUCCESS}"

########## Setup pip2
printf "Setting up ${COLOR_CODE}pip2${COLOR_NORMAL}...\n"

pip2 install --upgrade pip setuptools wheel
pip2 install --user --upgrade neovim

printf "${SUCCESS}"

########## Setup pip3
printf "Setting up ${COLOR_CODE}pip3${COLOR_NORMAL}...\n"

pip3 install --upgrade pip setuptools wheel
pip3 install --user --upgrade neovim

pip3 install termdown

printf "${SUCCESS}"

########## Setup npm
printf "Setting up ${COLOR_CODE}npm${COLOR_NORMAL}...\n"

npm install -g neovim

printf "${SUCCESS}"

########## Setup zsh
printf "Change the default shell to ${COLOR_CODE}zsh${COLOR_NORMAL}...\n"

if [ ! $(echo $SHELL) == `which zsh` ]; then
  chsh -s `which zsh`
fi

printf "${SUCCESS}"

########## Setup Antibody
printf "Setting up ${COLOR_CODE}Antibody${COLOR_NORMAL}...\n"

antibody update
antibody bundle < ~/.zsh.plugins > ~/.zsh_plugins.sh

printf "${SUCCESS}"

########## Setup tpm
printf "Setting up ${COLOR_CODE}tmux plugin manager${COLOR_NORMAL}...\n"

if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  cd ~/.tmux/plugins/tpm
  git pull
  cd
fi

printf "${SUCCESS}"

########## Setup minpac
printf "Setting up ${COLOR_CODE}minpac${COLOR_NORMAL}...\n"

if [ ! -d ~/.config/nvim/pack/minpac/opt/minpac ]; then
  git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac
else
  cd ~/.config/nvim/pack/minpac/opt/minpac
  git pull
  cd
  echo "Info: Please run :PackUpdate in nvim afterwards"
fi

printf "${SUCCESS}"

########## Set macOS preferences
printf "Setting some sensible ${COLOR_CODE}macOS${COLOR_NORMAL} preferences...\n"

defaults write -g InitialKeyRepeat -int 20
defaults write -g KeyRepeat -int 1
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

killall Finder

printf "${SUCCESS}"

########## The End
printf "${COLOR_SUCCESS}That's it!${COLOR_NORMAL}\n"
