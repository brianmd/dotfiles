To install, clone and make as follows:

    Note: if make does not exist on your ubuntu, run:
        sudo apt-get -y install build-essential

    mkdir -p ~/.config && git clone git@github.com:brianmd/dotfiles.git ~/.config/dotfiles
       OR
    mkdir -p ~/.config && git clone https://github.com/brianmd/dotfiles.git ~/.config/dotfiles

       AND THEN
    cd ~/.config/dotfiles && sudo make root_install_dev && make install_dev

       IF DON'T NEED RUBY
    cd ~/.config/dotfiles && sudo make root_install_user && make install_user


    sudo apt install -y zsh vim git gcc make curl emacs gnome-tweaks
        gnome-tweaks to allow changing caps lock to ctrl
    sudo visudo => username ALL=(ALL) NOPASSWD: ALL
    make relink
    make force_install_spacemacs
    chsh -s $(which zsh) # have to log out and back in to take effect
