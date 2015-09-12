# TODO: remove the git config to my name ...
# TODO: .oh-my installs a .zshrc file, so mine doesn't get installed.
#
# TODO: could add apt-get update && apt-get upgrade, but want salt to do that
# TODO: show insert/normal on command line
# TODO: teamocil?


TARGETS = $(HOME)/.pryrc $(HOME)/.irbrc
SHELL = /usr/bin/env bash
SHELL_PROFILE = ~/.zshrc

define RBENV_ENV
	export PATH="${HOME}/.rbenv/bin:${PATH}"
	eval "$(rbenv init -)"
endef


relink:
	rm -f ~/.zshrc ~/.tmux.conf ~/.inputrc ~/.gitconfig ~/.gitignore_global
	ln -s ${HOME}/.config/dotfiles/etc/zshrc ~/.zshrc
	ln -s ${HOME}/.config/dotfiles/etc/tmux.conf ~/.tmux.conf
	ln -s ${HOME}/.config/dotfiles/etc/inputrc ~/.inputrc
	ln -s ${HOME}/.config/dotfiles/etc/gitconfig ~/.gitconfig
	# ln -s ${HOME}/.config/dotfiles/vim/vimrc.mine ~/.vim/vimrc.mine
	# .gitconfig points directly to the global ignore. don't need it in home
	# directory.  ln -s ${HOME}/.config/dotfiles/etc/gitignore_global ~/.gitignore_global
	$(MAKE) relink_vim

relink_vim:
	rm -f ~/.vim ~/.vimrc
	# this is a fix for those that aren't using .vim as a link
	rm -rf ~/.vim
	ln -s ${HOME}/.config/dotfiles/vim ~/.vim
	ln -s ${HOME}/.config/dotfiles/vim/vimrc ~/.vimrc

test:
	grep xtest ~/.test || [ $$? -eq 0 ]
	echo te >> ~/.test

root_install_dev: root_add_salt_repository root_install_user linux_rbenv_prerequisites
	$(MAKE) ~/.config/direnv

x:
	sudo echo "\\nhello $$PATH"

root_install_jenkins:
	#wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
	sudo bash -c "echo 'deb http://pkg.jenkins-ci.org/debian binary/' >>/etc/apt/sources.list"
	sudo apt-get update
	sudo apt-get -y install jenkins
	sudo service jenkins start

root_add_salt_repository:
	add-apt-repository ppa:saltstack/salt

root_install_user:
	apt-get -y update
	apt-get upgrade
	# zlib1g-dev: for installing nokogirl.
	# python-software-properties: for salt.
	apt-get -y install git silversearcher-ag golang tree keychain zsh htop tmux python-software-properties zlib1g-dev
	git config --global user.email "brian@murphydye.com"
	git config --global user.name "Brian Murphy-Dye"

root_install_vagrant:
	apt-get -y install virtualbox vagrant virtualbox-dkms
	# required for packer and boxcutter
	apt-get install -y virtualbox-guest-additions-iso
	wget https://bootstrap.pypa.io/ez_setup.py -O - | python
	easy_install pip

root_install_plex:
	mkdir -p ~/downloads
	cd ~/downloads && wget https://downloads.plex.tv/plex-media-server/0.9.12.11.1406-8403350/plexmediaserver_0.9.12.11.1406-8403350_amd64.deb
	cd ~/downloads && dpkg -i plexmediaserver_0.9.12.11.1406-8403350_amd64.deb

install_vagrant:
	vagrant plugin install vagrant-hostmanager

root_mac_baseinstall:
	brew install ag

root_create_shares: /usr/share/provisioners

/usr/share/provisioners:
	mkdir -p /usr/share/provisioners/vagrant.d
	mkdir -p /usr/share/provisioners/packers
	chmod -R a+rwx /usr/share/provisioners

~/.config/packer:
	mkdir -p ~/.config/packer
	#cd ~/.config && git clone https://github.com/mitchellh/packer.git
	cd ~/.config/packer && wget https://dl.bintray.com/mitchellh/packer/packer_0.8.6_linux_amd64.zip && unzip packer_0.8.6_linux_amd64.zip && rm packer_0.8.6_linux_amd64.zip

~/.config/direnv:
	mkdir -p ~/.config
	git clone https://github.com/direnv/direnv ~/.config/direnv
	cd ~/.config/direnv && make install

linux_rbenv_prerequisites:
	# from https://github.com/sstephenson/ruby-build/wiki
	apt-get -y install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

mac_rbenv_prerequisites:
	brew install openssl libyaml libffi

root_adduser:
	echo "missing MNAME environment variable."
	exit 1
	adduser ${MNAME}
	$(MAKE) root_cpdot

root_cpdot:
	mkdir -p /home/${MNAME}/.config
	cp -r ~/.config/dotfiles /home/${MNAME}/.config
	chown -R ${MNAME}:${MNAME} /home/${MNAME}/.config




install_dev: install_user ~/.rbenv ~/.irb ~/.rbenv/shims/ruby
	echo 'you must now restart your shell'
	echo 'type rbenv   should return that rbenv is a function'
	echo 'from the new shell, type  make install_ruby'

install_user: ~/.vim ~/.oh-my-zsh ~/.zshrc ~/.tmux.conf
	git config --global user.email "brian@murphydye.com"
	git config --global user.name "Brian Murphy-Dye"
	$(MAKE) relink

install_github:
	cd ~/code && git clone git@github.com:brianmd/collectr.git
	cd ~/code && git clone git@github.com:brianmd/requirer.git
	cd ~/code && git clone git@github.com:brianmd/searchr.git
	cd ~/code && git clone git@github.com:brianmd/searchr-rails.git
	cd ~/code && git clone git@github.com:brianmd/saltr.git
	cd ~/code && git clone git@github.com:brianmd/shenvy.git
	cd ~/code && git clone git@github.com:brianmd/network-tester.git




~/.vimold:
	# ctrlp: http://kien.github.io/ctrlp.vim/
	git clone git://github.com/nviennot/vim-config.git ~/.vim
	cd ~/.vim && make install
	cp etc/vimrc.mine ~/.vim/vimrc.mine
	# add emacs key bindings while in insert mode
	cd ~/.vim && git clone git://github.com/tpope/vim-rsi.git
	$(MAKE) install_vim



force_install_vim:
	rm -f ~/.vim
	rm -rf ~/.vim
	$(MAKE) install_vim

install_vim: ~/.vim

~/.vim:
	mkdir -p ~/.config/dotfiles/vim/bundle
	touch ~/.config/dotfiles/vim/vimrc.mine
	touch ~/.config/dotfiles/vim/gvimrc.mine
	$(MAKE) relink_vim
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/dotfiles/vim/bundle/Vundle.vim || echo 'vundle already installed'
	# install the plugins from vimrc.mine
	#$(MAKE) ~/.config/dotfiles/vim/bundle/Vundle.vim
	$(MAKE) install_vim_plugins

update_vim_plugins:
	vim +PluginInstall! +qall

install_vim_plugins:
	vim +PluginInstall +qall


~/.tmux.conf:
	git clone git://github.com/nviennot/tmux-config.git ~/.tmux
	cd ~/.tmux && make install



install_zshrc: ~/.oh-my-zsh ~/.zshrc

~/.oh-my-zsh:
	mkdir -p ~/.config/ohmy
	curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o ~/.config/ohmy/install.sh
	chmod a+x ~/.config/ohmy/install.sh
	cd ~/.config/ohmy && ./install.sh
	#sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	# chsh -s /usr/bin/zsh

~/.zshrc:
	ln -s ${HOME}/.config/dotfiles/etc/zshrc ${HOME}/.zshrc



~/.rbenv:
	git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
	git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
	grep rbenv $(SHELL_PROFILE) || [ $$? -eq 0 ]
	echo '------------------------------------------------'
	# cat rbenv-sh.txt >> $(SHELL_PROFILE)
	# $(MAKE) install_ruby_build

old_install_rubies:
	rbenv install 2.1.5
	rbenv global 2.1.5
	rehash

~/.irb:
	# see http://velvetpulse.com/2012/11/19/improve-your-ruby-workflow-by-integrating-vim-tmux-pry/
	git clone git://github.com/nviennot/irb-config.git ~/.irb
	cd ~/.irb && make install

~/.rbenv/shims/ruby:
	curl -sSL http://getrbenv.com/install | bash -s -- --rubies 2.1.5 --global-ruby 2.1.5 --plugins sstephenson/ruby-build,sstephenson/rbenv-gem-rehash
	#curl -sSL http://getrbenv.com/install | bash -s -- --rubies 2.1.5,2.2.2 --global-ruby 2.2.2 --plugins sstephenson/ruby-build,sstephenson/rbenv-gem-rehash

