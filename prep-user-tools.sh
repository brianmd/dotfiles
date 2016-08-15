#!/bin/bash

rm -f ~/.zshrc ~/.tmux.conf ~/.inputrc ~/.gitconfig ~/.gitignore_global ~/.rspec ~/.spacemacs
rm -f ~/.zshrc ~/.tmux.conf ~/.inputrc ~/.gitconfig ~/.gitignore_global ~/.rspec ~/.spacemacs
rm -f ~/.vim
rm -rf ~/.vim

# .oh-my-zsh:
mkdir -p ~/.config/ohmy
curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o ~/.config/ohmy/install.sh
chmod a+x ~/.config/ohmy/install.sh
cd ~/.config/ohmy && ./install.sh
#sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# remove vim links, and .vim as a directory
rm -f ~/.vim ~/.vimrc
rm -rf ~/.vim
ln -s ${HOME}/.config/dotfiles/vim ~/.vim
ln -s ${HOME}/.config/dotfiles/vim/vimrc ~/.vimrc

# vim
mkdir -p ~/.config/dotfiles/vim/bundle
mkdir -p ~/.config/dotfiles/vim/swap
mkdir -p ~/.config/dotfiles/vim/undo
touch ~/.config/dotfiles/vim/vimrc.mine
touch ~/.config/dotfiles/vim/gvimrc.mine
$(MAKE) relink_vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/dotfiles/vim/bundle/Vundle.vim || echo 'vundle already installed'

# direnv
git clone https://github.com/direnv/direnv ~/.config/direnv
cd ~/.config/direnv && make install    # note: needs go (golang). apt-get installs old version, which seems to be fine

git clone git@github.com:brianmd/binfiles.git ~/.config/binfiles

ln -s ${HOME}/.config/dotfiles/etc/zshrc ~/.zshrc
ln -s ${HOME}/.config/dotfiles/etc/tmux.conf ~/.tmux.conf
ln -s ${HOME}/.config/dotfiles/etc/inputrc ~/.inputrc
ln -s ${HOME}/.config/dotfiles/etc/gitconfig ~/.gitconfig
ln -s ${HOME}/.config/dotfiles/etc/rspec ~/.rspec
ln -s ${HOME}/.config/dotfiles/etc/spacemacs ~/.spacemacs

vim +PlugInstall

# chsh -s /usr/bin/zsh
