To install, clone and make as follows:

    mkdir -p ~/.config && git clone https://github.com/brianmd/dotfiles.git
    ~/.config/dotfiles
       OR
    mkdir ~/.config && git clone git@github.com:brianmd/dotfiles.git ~/.config/dotfiles

       AND THEN
    cd ~/.config/dotfiles && sudo make root_install_dev && make install_dev

       IF DON'T NEED RUBY
    cd ~/.config/dotfiles && sudo make root_install_user && make install_user


    (have also needed to run: make relink. Will fix this one day ...)

