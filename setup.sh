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

brew install zsh
brew install tmux
brew install reattach-to-user-namespace
brew install git
brew install gitup
brew install tig
brew install archey
brew install coreutils
brew install rbenv
brew install ruby-build
brew install npm
brew install yarn
brew install autoconf
brew install tree
brew install wget
brew install gist
brew install mas
brew install youtube-dl
brew install the_silver_searcher
brew install libxml2 libxslt
brew install vim --with-override-system-vi
brew install optipng
brew install librsvg
brew install weechat
brew install imagemagick
brew install htop
brew install iftop
brew install postgresql
brew services restart postgresql
brew install redis
brew services start redis

brew tap getantibody/homebrew-antibody
brew install antibody

printf "${SUCCESS}"

printf "Installing essential ${COLOR_CODE}App Store${COLOR_NORMAL} packages...\n"

mas install 1039633667 # Irvue

printf "${SUCCESS}"

printf "Installing essential ${COLOR_CODE}homebrew cask${COLOR_NORMAL} packages...\n"

brew tap caskroom/cask
brew cask install iterm2
brew cask install google-chrome
brew cask install dropbox
brew cask install docker
brew cask install gpg-suite
brew cask install dash
brew cask install amethyst

brew cleanup

printf "${SUCCESS}"

########## Build and setup ruby
printf "Building the latest ${COLOR_CODE}ruby${COLOR_NORMAL} and setting it as default...\n"

eval "$(rbenv init -)"
LATEST_RUBY_VERSION=$(rbenv install -l | grep -v - | tail -1)
rbenv install $LATEST_RUBY_VERSION
rbenv global $LATEST_RUBY_VERSION

printf "${SUCCESS}"


########## Setup pip3
printf "Seting up ${COLOR_CODE}pip3${COLOR_NORMAL}...\n"

pip3 install --upgrade pip setuptools wheel

printf "${SUCCESS}"

########## Setup zsh
printf "Change the default shell to ${COLOR_CODE}zsh${COLOR_NORMAL}...\n"

if [ ! $(echo $SHELL) == `which zsh` ]; then
  chsh -s `which zsh`
fi

printf "${SUCCESS}"

########## Setup Antibody
printf "Seting up ${COLOR_CODE}Antibody${COLOR_NORMAL}...\n"

antibody update
antibody bundle < ~/.zsh.plugins > ~/.zsh_plugins.sh

printf "${SUCCESS}"

########## Setup tpm
printf "Seting up ${COLOR_CODE}tmux plugin manager${COLOR_NORMAL}...\n"

if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  cd ~/.tmux/plugins/tpm
  git pull
  cd
fi

printf "${SUCCESS}"

########## Setup vundle
printf "Seting up ${COLOR_CODE}vundle${COLOR_NORMAL}...\n"

if [ ! -d ~/.vim/bundle/vundle ]; then
  mkdir -p ~/.vim/bundle/vundle
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  echo "Info: Please run :BundleInstall in vim afterwards"
else
  cd ~/.vim/bundle/vundle
  git pull
  cd
fi

printf "${SUCCESS}"

########## Setup gems
printf "Installing essential ${COLOR_CODE}rubygems${COLOR_NORMAL}...\n"

gem install tmuxinator

printf "${SUCCESS}"

########## Install powerline fonts
printf "Installing ${COLOR_CODE}powerline${COLOR_NORMAL} fonts...\n"

rm -rf /tmp/fonts
git clone https://github.com/powerline/fonts.git /tmp/fonts
cd /tmp/fonts
./install.sh
cd
rm -rf /tmp/fonts

printf "${SUCCESS}"

########## Set macOS preferences
printf "Setting some sensible ${COLOR_CODE}macOS${COLOR_NORMAL} preferences...\n"

defaults write -g InitialKeyRepeat -int 20
defaults write -g KeyRepeat -int 1
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

killall Finder

printf "${SUCCESS}"

########## The End
printf "${COLOR_SUCCESS}That's it!${COLOR_NORMAL}\n"
