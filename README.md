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


    make relink   also comes in handy

