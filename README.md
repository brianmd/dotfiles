To install, clone and make as follows:

    mkdir ~/pkgs && git clone https://github.com/brianmd/dotfiles.git ~/pkgs/dotfiles
       OR
    mkdir ~/pkgs && git clone git@github.com:brianmd/dotfiles.git ~/pkgs/dotfiles

       AND THEN
    cd ~/pkgs/dotfiles && sudo make root_install_dev && make install_dev

       IF DON'T NEED RUBY
    cd ~/pkgs/dotfiles && sudo make root_install_user && make install_user


    (have also needed to run: make relink. Will fix this one day ...)

