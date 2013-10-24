#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
echo "Moving any existing dotfiles from ~ to $olddir and creating symlinks to the dotfiles."
for file in $dir/*; do
  filename=$(basename "$file")
  if [ "$filename" != "symlink.sh" ]; then
    echo $filename
    cp ~/.$filename ~/dotfiles_old/$filename
    rm ~/.$filename

    ln -s $file ~/.$filename
  fi
done

function clone_oh_my_zsh {
  # Test to see if zshell is installed.  If it is:
  if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone oh-my-zsh repository from GitHub only if it isn't already present
    if [ ! -d ~/.oh-my-zsh/ ]; then
      git clone git@github.com:robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi

    # Set the default shell to zsh if it isn't currently set to zsh
    if [ ! $(echo $SHELL) == $(which zsh) ]; then
      chsh -s $(which zsh)
      echo "Info: Please run source ~/.zshrc"
    fi
  else
    # If the platform is OS X, tell the user to install zsh
    echo "Please install zsh, then re-run this script!"
    exit
  fi
}

function clone_vundle {
  # Clone vundle repository from GitHub only if it isn't already present
  if [ ! -d ~/.vim/bundle/vundle/ ]; then
    mkdir -p ~/.vim/bundle/vundle
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    echo "Info: Please run :BundleInstall in vim afterwards"
  fi
}

clone_oh_my_zsh
clone_vundle
