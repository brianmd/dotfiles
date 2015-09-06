# mkdir -p ~/pkgs && git clone https://github.com/brianmd/dotfiles.git ~/pkgs/dotfiles
#     OR, if able to update github:
# mkdir -p ~/pkgs && git clone git@github.com:brianmd/dotfiles.git ~/pkgs/dotfiles
#
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
	rm -f ~/.zshrc ~/.tmux.conf ~/.inputrc ~/.gitconfig ~/.gitignore_global ~/.vim/vimrc.mine
	ln -s ${HOME}/pkgs/dotfiles/etc/zshrc ~/.zshrc
	ln -s ${HOME}/pkgs/dotfiles/etc/tmux.conf ~/.tmux.conf
	ln -s ${HOME}/pkgs/dotfiles/etc/inputrc ~/.inputrc
	ln -s ${HOME}/pkgs/dotfiles/etc/gitconfig ~/.gitconfig
	ln -s ${HOME}/pkgs/dotfiles/etc/vimrc.mine ~/.vim/vimrc.mine
	# .gitconfig points directly to the global ignore. don't need it in home
	# directory.  ln -s ${HOME}/pkgs/dotfiles/etc/gitignore_global ~/.gitignore_global

test:
	grep xtest ~/.test || [ $$? -eq 0 ]
	echo te >> ~/.test

root_install_dev: root_add_salt_repository root_install_user linux_rbenv_prerequisites
	$(MAKE) ~/pkgs/direnv

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

~/pkgs/packer:
	mkdir -p ~/pkgs/packer
	#cd ~/pkgs && git clone https://github.com/mitchellh/packer.git
	cd ~/pkgs/packer && wget https://dl.bintray.com/mitchellh/packer/packer_0.8.6_linux_amd64.zip && unzip packer_0.8.6_linux_amd64.zip && rm packer_0.8.6_linux_amd64.zip

~/pkgs/direnv:
	mkdir -p ~/pkgs
	git clone https://github.com/direnv/direnv ~/pkgs/direnv
	cd ~/pkgs/direnv && make install

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
	mkdir -p /home/${MNAME}/pkgs
	cp -r ~/pkgs/dotfiles /home/${MNAME}/pkgs
	chown -R ${MNAME}:${MNAME} /home/${MNAME}/pkgs




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


~/.vim:
	# ctrlp: http://kien.github.io/ctrlp.vim/
	git clone git://github.com/nviennot/vim-config.git ~/.vim
	cd ~/.vim && make install
	cp etc/vimrc.mine ~/.vim/vimrc.mine
	# add emacs key bindings while in insert mode
	cd ~/.vim && git clone git://github.com/tpope/vim-rsi.git


~/.tmux.conf:
	git clone git://github.com/nviennot/tmux-config.git ~/.tmux
	cd ~/.tmux && make install



install_zshrc: ~/.oh-my-zsh ~/.zshrc

~/.oh-my-zsh:
	mkdir -p ~/pkgs/ohmy
	curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o ~/pkgs/ohmy/install.sh
	chmod a+x ~/pkgs/ohmy/install.sh
	cd ~/pkgs/ohmy && ./install.sh
	#sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	# chsh -s /usr/bin/zsh

~/.zshrc:
	ln -s ${HOME}/pkgs/dotfiles/etc/zshrc ${HOME}/.zshrc



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

