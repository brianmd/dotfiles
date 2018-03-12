#!/bin/bash

rm -f ~/.zshrc ~/.tmux.conf ~/.inputrc ~/.gitconfig ~/.gitignore_global ~/.rspec ~/.spacemacs ~/.vim ~/.vimrc
rm -rf ~/.vim ~/.config/dotfiles/vim/bundle

mkdir -p ~/.config/gocode
# .oh-my-zsh:
mkdir -p ~/.config/ohmy
curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o ~/.config/ohmy/install.sh
chmod a+x ~/.config/ohmy/install.sh
(cd ~/.config/ohmy && echo "exit" | ./install.sh)
#sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d || echo 'emacs.d is good to go'

ln -s ${HOME}/.config/dotfiles/vim ~/.vim
ln -s ${HOME}/.config/dotfiles/vim/vimrc ~/.vimrc 

# vim
mkdir -p ~/.config/dotfiles/vim/bundle
mkdir -p ~/.config/dotfiles/vim/swap
mkdir -p ~/.config/dotfiles/vim/undo
touch ~/.config/dotfiles/vim/vimrc.mine
touch ~/.config/dotfiles/vim/gvimrc.mine
git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/dotfiles/vim/bundle/Vundle.vim || echo 'vundle is good to go'

# direnv
git clone https://github.com/direnv/direnv ~/.config/direnv || echo 'direnv is good to go'
cd ~/.config/direnv && make install    # note: needs go (golang). apt-get installs old version, which seems to be fine

git clone https://github.com/brianmd/binfiles.git ~/.config/binfiles || echo 'binfiles is good to go'

rm -f ~/.zshrc
ln -s ${HOME}/.config/dotfiles/etc/zshrc ~/.zshrc
ln -s ${HOME}/.config/dotfiles/etc/tmux.conf ~/.tmux.conf
ln -s ${HOME}/.config/dotfiles/etc/inputrc ~/.inputrc
ln -s ${HOME}/.config/dotfiles/etc/gitconfig ~/.gitconfig
ln -s ${HOME}/.config/dotfiles/etc/rspec ~/.rspec
ln -s ${HOME}/.config/dotfiles/spacemacs/spacemacs ~/.spacemacs

# vim +PlugInstall
echo "to install vim plugins: vim +PlugInstall"

# chsh -s /bin/zsh
