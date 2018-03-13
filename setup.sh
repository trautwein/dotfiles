#!/bin/bash

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # backup directory
setupfile=setup.sh                # the filename of this script

color_normal=$(tput sgr0)
color_code=$(tput setaf 4)
color_success=$(tput setaf 2)

success="${color_success}┌───────────────────────┐\n│         Done!         │\n└───────────────────────┘${color_normal}\n\n"

########## Dotfiles backup and symlinking
printf "${color_normal}Backing up any existing dotfiles to ${color_code}${olddir}${color_normal} and linking the ones from ${color_code}${dir}${color_normal}...\n"

mkdir -p $olddir
cd $dir

for file in $dir/*; do
  filename=$(basename "$file")
  if [ "$filename" != "$setupfile" ]; then
    printf "${filename}\n"
    cp ~/.$filename ~/dotfiles_old/$filename
    rm ~/.$filename

    ln -s $file ~/.$filename
  fi
done

touch ~/.zshrc.aliases ~/.zshrc.env

printf "${success}"

########## Install and setup homebrew and packages
printf "Installing ${color_code}homebrew${color_normal} if it's not present...\n"

if [ ! -f /usr/local/bin/brew ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

printf "${success}"

printf "Setting up ${color_code}homebrew${color_normal}...\n"

brew update && brew doctor && brew upgrade

printf "${success}"

printf "Installing essential ${color_code}homebrew${color_normal} packages...\n"

brew install zsh
brew install tmux
brew install reattach-to-user-namespace
brew install git
brew install tig
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
brew install postgresql
brew services restart postgresql
brew install redis
brew services start redis

printf "${success}"

printf "Installing essential ${color_code}App Store${color_normal} packages...\n"

mas install 441258766 # Magnet

printf "${success}"

printf "Installing essential ${color_code}homebrew cask${color_normal} packages...\n"

brew tap caskroom/cask
brew cask install iterm2
brew cask install google-chrome
brew cask install dropbox
brew cask install docker
brew cask install gpg-suite

brew cleanup

printf "${success}"

########## Build and setup ruby
printf "Building the latest ${color_code}ruby${color_normal} and setting it as default...\n"

eval "$(rbenv init -)"
LATEST_RUBY_VERSION=$(rbenv install -l | grep -v - | tail -1)
rbenv install $LATEST_RUBY_VERSION
rbenv global $LATEST_RUBY_VERSION

printf "${success}"


########## Setup pip3
printf "Seting up ${color_code}pip3${color_normal}...\n"

pip3 install --upgrade pip setuptools wheel

printf "${success}"

########## Setup zsh
printf "Change the default shell to ${color_code}zsh${color_normal}...\n"

chsh -s /bin/zsh

printf "${success}"

########## Setup oh-my-zsh
printf "Seting up ${color_code}oh-my-zsh${color_normal}...\n"

if [ ! -d ~/.oh-my-zsh/ ]; then
  git clone git@github.com:robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
else
  cd ~/.oh-my-zsh
  git pull
  cd
fi

printf "${success}"

########## Setup tpm
printf "Seting up ${color_code}tmux plugin manager${color_normal}...\n"

if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  cd ~/.tmux/plugins/tpm
  git pull
  cd
fi

printf "${success}"

########## Setup vundle
printf "Seting up ${color_code}vundle${color_normal}...\n"

if [ ! -d ~/.vim/bundle/vundle ]; then
  mkdir -p ~/.vim/bundle/vundle
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  echo "Info: Please run :BundleInstall in vim afterwards"
else
  cd ~/.vim/bundle/vundle
  git pull
  cd
fi

printf "${success}"

########## Setup gems
printf "Installing essential ${color_code}rubygems${color_normal}...\n"

gem install tmuxinator

printf "${success}"

########## Install powerline fonts
printf "Installing ${color_code}powerline${color_normal} fonts...\n"

rm -rf /tmp/fonts
git clone https://github.com/powerline/fonts.git /tmp/fonts
cd /tmp/fonts
./install.sh
cd
rm -rf /tmp/fonts

printf "${success}"

########## Set macOS preferences
printf "Setting some sensible ${color_code}macOS${color_normal} preferences...\n"

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

printf "${success}"

########## The End
printf "${color_success}That's it!${color_normal}\n"
