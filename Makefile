# TODO: remove the git config to my name ...
# TODO: .oh-my installs a .zshrc file, so mine doesn't get installed.
#
# TODO: could add apt-get update && apt-get upgrade, but want salt to do that
# TODO: show insert/normal on command line
# TODO: teamocil?
#
#
#
#    for json pretty print emacs needs:
#           npm -g install js-beautify


TARGETS = $(HOME)/.pryrc $(HOME)/.irbrc
SHELL = /usr/bin/env bash
SHELL_PROFILE = "${HOME}/.zshrc"

define RBENV_ENV
	export PATH="${HOME}/.rbenv/bin:${PATH}"
	eval "$(rbenv init -)"
endef

chromebook:
	pkg install curl wget git silversearcher-ag make zsh mosh

root_install_make:
	sudo apt-get -y install build-essential

weechat:
	# the easy way: docker run -t -i fstab/weechat-otr
	sudo apt install libncurses-dev libcurl4-openssl-dev zlib1g-dev libgcrypt20 cmake -y
	wget https://weechat.org/files/src/weechat-2.0.1.tar.gz
	dxtr weechat*
	rm weechat*.tar.gz
	cd weechat*
	mkdir build
	cd build
	cmake ..
	make
	sudo make install

relink:
	$(MAKE) "${HOME}/.oh-my-zsh"
	# $(MAKE) "${HOME}/.config/direnv"
	mkdir -p "${HOME}/.config/i3"
	rm -f "${HOME}/.zshrc" "${HOME}/.zshenv" "${HOME}/.tmux.conf" "${HOME}/.inputrc" "${HOME}/.gitconfig" "${HOME}/.gitignore"_global "${HOME}/.rspec" "${HOME}/.spacemacs"
	ln -s ${HOME}/.config/dotfiles/zsh/zshenv "${HOME}/.zshenv"
	ln -s ${HOME}/.config/dotfiles/zsh/zshrc "${HOME}/.zshrc"
	ln -s ${HOME}/.config/dotfiles/etc/tmux.conf "${HOME}/.tmux.conf"
	ln -s ${HOME}/.config/dotfiles/etc/inputrc "${HOME}/.inputrc"
	ln -s ${HOME}/.config/dotfiles/etc/gitconfig "${HOME}/.gitconfig"
	ln -s ${HOME}/.config/dotfiles/etc/rspec "${HOME}/.rspec"
	ln -s ${HOME}/.config/dotfiles/spacemacs/spacemacs "${HOME}/.spacemacs"
	([ ! -f "${HOME}/.config/i3/config" ] && ln -s "${HOME}/.config/dotfiles/i3/config" "${HOME}/.config/i3/config") || true
	# ln -s ${HOME}/.config/dotfiles/vim/vimrc.mine "${HOME}/.vim/vimrc.mine"
	# .gitconfig points directly to the global ignore. don't need it in home
	# directory.  ln -s ${HOME}/.config/dotfiles/etc/gitignore_global "${HOME}/.gitignore_global"
	# $(MAKE) relink_vim
	$(MAKE) force_install_vim

relink_vim:
	rm -f "${HOME}/.vim "${HOME}/.vimrc"
	# this is a fix for those that aren't using .vim as a link
	rm -rf "${HOME}/.vim"
	ln -s "${HOME}/.config/dotfiles/vim "${HOME}/.vim"
	ln -s "${HOME}/.config/dotfiles/vim/vimrc "${HOME}/.vimrc"
	$(MAKE) install_vimrc_mine

test:
	grep xtest "${HOME}/.test" || [ $$? -eq 0 ]
	echo te >> "${HOME}/.test"

# root_install_dev: root_add_salt_repository root_install_user linux_rbenv_prerequisites
root_install_dev: root_install_user linux_rbenv_prerequisites
	$(MAKE) "${HOME}/.config/direnv"

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
	apt-get -y install git silversearcher-ag golang tree keychain zsh htop tmux python-software-properties zlib1g-dev exuberant-ctags mercurial jq mosh shellcheck
	# this allows unzipping encrypted files w/ '7z x filename' or '7z e filename'
	apt-get -y install p7zip-full
	#git config --global user.email "brian@murphydye.com"
	#git config --global user.name "Brian Murphy-Dye"

root_install_vagrant:
	apt-get -y install virtualbox vagrant virtualbox-dkms
	# required for packer and boxcutter
	apt-get install -y virtualbox-guest-additions-iso
	wget https://bootstrap.pypa.io/ez_setup.py -O - | python
	easy_install pip

install_nodenv:
	git clone https://github.com/nodenv/nodenv.git "${HOME}/.nodenv"
	nodenv install v4.2.2
	nodenv rehash

root_install_java:
	add-apt-repository ppa:webupd8team/java
	apt-get update
	apt-get install oracle-java8-installer

root_install_plex:
	# use 'sudo blkid' to find the appropriate /dev/sd??
	# sudo mount -t hfsplus -o force,rw /dev/sdb2 /media/bmd
	# above isn't working -- seems drive is now on sda2
	# mount -t hfsplus -o force,rw /dev/sda2 /media/bmd
	#
	# log files: /var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Logs/
	sudo apt-get -y install nfs-common nfs-kernel-server
	mkdir -p "${HOME}/downloads"
	cd "${HOME}/downloads" && wget https://downloads.plex.tv/plex-media-server/0.9.12.11.1406-8403350/plexmediaserver_0.9.12.11.1406-8403350_amd64.deb
	cd "${HOME}/downloads" && dpkg -i plexmediaserver_0.9.12.11.1406-8403350_amd64.deb

install_vagrant:
	vagrant plugin install vagrant-hostmanager

root_create_shares: /usr/share/provisioners

/usr/share/provisioners:
	mkdir -p /usr/share/provisioners/vagrant.d
	mkdir -p /usr/share/provisioners/packers
	chmod -R a+rwx /usr/share/provisioners

~/.config/packer:
	mkdir -p "${HOME}/.config/packer"
	#cd "${HOME}/.config" && git clone https://github.com/mitchellh/packer.git
	cd "${HOME}/.config/packer" && wget https://dl.bintray.com/mitchellh/packer/packer_0.8.6_linux_amd64.zip && unzip packer_0.8.6_linux_amd64.zip && rm packer_0.8.6_linux_amd64.zip

~/.config/direnv:
	mkdir -p "${HOME}/.config"
	git clone https://github.com/direnv/direnv "${HOME}/.config/direnv"
	sudo apt-get install -y go
	cd "${HOME}/.config/direnv" && make install

linux_rbenv_prerequisites:
	# from https://github.com/sstephenson/ruby-build/wiki
	# note: build-essential has make
	apt-get -y install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

why_root_mac_baseinstall:
	# why should these be run as root?????
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew doctor
	brew install ag
	brew install vim  # bumps default mac version from 7.3 to 7.4
	brew install emacs --with-x
	brew install redis
	brew install mongodb
	brew install mariadb
	brew install watchman
	brew install sqlite
	brew install caskroom/cask/brew-cask
	brew cask install google-chrome
	brew cask install launchrocket
	brew cask install keepingyouawake
	brew cask install virtualbox
	brew cask install vagrant
	brew cask install vagrant-manager
	brew install ctags
	# phantomjs hasn't been updated for el capitan
	# brew install phantomjs

mac_base_config:
	# there are tons of great mac config statements at
	# https://gist.github.com/kimmobrunfeldt/350f4898d1b82cf10bce
	#Enable repeat on keydown
	defaults write -g ApplePressAndHoldEnabled -bool false
	#Use current directory as default search scope in Finder
	defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
	#Show Path bar in Finder
	defaults write com.apple.finder ShowPathbar -bool true
	#Show Status bar in Finder
	defaults write com.apple.finder ShowStatusBar -bool true
	#Show indicator lights for open applications in the Dock
	defaults write com.apple.dock show-process-indicators -bool true
	#Enable AirDrop over Ethernet and on unsupported Macs running Lion
	defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true
	#Set a blazingly fast keyboard repeat rate
	defaults write NSGlobalDomain KeyRepeat -int 0.02
	#Set a shorter Delay until key repeat
	defaults write NSGlobalDomain InitialKeyRepeat -int 12
	#Enable Safari’s debug menu
	defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
	#Add a context menu item for showing the Web Inspector in web views
	defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
	#Show the ~/Library folder
	chflags nohidden "${HOME}/Library"

mac_rbenv_prerequisites:
	brew install openssl libyaml libffi
	brew link openssl --force
	brew install htop

mac_gnu_tools:
	brew tap homebrew/dupes
	brew install findutils --default-names
	brew install gnu-sed --default-names
	brew install gnu-tar --default-names
	brew install gnu-which --default-names
	brew install gnutls --default-names
	brew install grep --default-names
	brew install coreutils
	brew install binutils
	brew install diffutils
	brew install gzip
	brew install watch
	brew install tmux
	# this makes pbcopy/pbpaste work in tmux
	brew install reattach-to-user-namespace
	brew install wget
	brew install nmap
	brew install gpg
	brew install htop

mac_install_direnv: "${HOME}/.config/direnv"

root_adduser:
	echo "missing MNAME environment variable."
	exit 1
	adduser ${MNAME}
	$(MAKE) root_cpdot

root_cpdot:
	mkdir -p /home/${MNAME}/.config
	cp -r "${HOME}/.config/dotfiles" /home/${MNAME}/.config
	chown -R ${MNAME}:${MNAME} /home/${MNAME}/.config




install_dev: install_user "${HOME}/.rbenv" "${HOME}/.irb" "${HOME}/.rbenv/shims/ruby"
	echo 'you must now restart your shell'
	echo 'type rbenv   should return that rbenv is a function'
	echo 'from the new shell, type  make install_ruby'

install_user: "${HOME}/.vim" "${HOME}/.oh-my-zsh" "${HOME}/.zshrc" "${HOME}/.tmux.conf"
	#git config --global user.email "brian@murphydye.com"
	#git config --global user.name "Brian Murphy-Dye"
	$(MAKE) relink

install_github:
	cd "${HOME}/code" && git clone git@github.com:brianmd/collectr.git
	cd "${HOME}/code" && git clone git@github.com:brianmd/requirer.git
	cd "${HOME}/code" && git clone git@github.com:brianmd/searchr.git
	cd "${HOME}/code" && git clone git@github.com:brianmd/searchr-rails.git
	cd "${HOME}/code" && git clone git@github.com:brianmd/saltr.git
	cd "${HOME}/code" && git clone git@github.com:brianmd/shenvy.git
	cd "${HOME}/code" && git clone git@github.com:brianmd/network-tester.git

root_install_mariadb:
	add-apt-repository 'deb [arch=amd64,i386] http://sfo1.mirrors.digitalocean.com/mariadb/repo/10.1/ubuntu xenial main'
	apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
	apt-get update
	apt-get install -y software-properties-common mariadb-server

install_ubuntu_chefdk:
	wget "https://packages.chef.io/files/stable/chefdk/2.2.1/ubuntu/16.04/chefdk_2.2.1-1_amd64.deb" -O /tmp/chefdk.deb
	sudo dpkg -i /tmp/chefdk.deb
	echo 'need: export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"'

install_centos_chefdk:
	wget "https://packages.chef.io/files/stable/chefdk/2.2.1/el/7/chefdk-2.2.1-1.el7.x86_64.rpm"
	sudo dpkg -i /tmp/chefdk.deb
	echo 'need: export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"'

install_ubuntu_vagrant:
	wget "https://releases.hashicorp.com/vagrant/2.0.0/vagrant_2.0.0_x86_64.deb" -O /tmp/vagrant.deb
	sudo dpkg -i /tmp/vagrant.deb


install_emacs25_ubuntu:
	sudo apt-get -y remove emacs
	sudo add-apt-repository ppa:ubuntu-elisp/ppa
	sudo apt-get update
	sudo apt-get -y install emacs-snapshot
	echo
	echo
	echo "select 'emacs-snapshot from the menu after running: sudo update-alternatives --config emacs"
	sudo update-alternatives --config emacs
	echo
	echo
	echo "if running bash on windows, run vcxsrv, then:"
	echo "    export DISPLAY=:0 ; (i3 &) ; (terminator &)"

~/.emacs.d:
	${MAKE} force_install_spacemacs

force_install_spacemacs:
	rm -rf "${HOME}/.emacs.d"
	git clone https://github.com/syl20bnr/spacemacs "${HOME}/.emacs.d"
	git clone https://github.com/venmos/w3m-layer.git "${HOME}/.emacs.d/private/w3"
	rm -f "${HOME}/.spacemacs"
	ln -s "${HOME}/.config/dotfiles/spacemacs/spacemacs" "${HOME}/.spacemacs"
	# install layers and quit
	emacs -nw -batch -u $$USER -q -kill
	emacs -nw -batch -u $$USER -q -kill
	sed -i "s/dotspacemacs-install-packages 'all/dotspacemacs-install-packages 'used-but-keep-unused/g" "${HOME}/.spacemacs"
	emacs -nw -batch -u $$USER -q -kill

~/.vimold:
	# ctrlp: http://kien.github.io/ctrlp.vim/
	git clone git://github.com/nviennot/vim-config.git "${HOME}/.vim"
	cd "${HOME}/.vim" && make install
	#cp etc/vimrc.mine "${HOME}/.vim/vimrc.mine"
	# add emacs key bindings while in insert mode
	cd "${HOME}/.vim" && git clone git://github.com/tpope/vim-rsi.git
	$(MAKE) install_vim

force_install_vim:
	echo "\nin force-install-vim"
	rm -f "${HOME}/.vim" "${HOME}/.vimrc"
	rm -rf "${HOME}/.vim"
	rm -rf "${HOME}/.config/dotfiles/vim/bundle"
	rm -rf "${HOME}/.config/dotfiles/vim/plugged"
	#ln -s ${HOME}/.config/dotfiles/vim "${HOME}/.vim"
	#ln -s ${HOME}/.config/dotfiles/vim/vimrc "${HOME}/.vimrc"
	$(MAKE) install_vim

install_vim: ${HOME}/.vim

~/.vim:
	echo "\nin .vim"
	mkdir -p "${HOME}/.config/dotfiles/vim/swap"
	mkdir -p "${HOME}/.config/dotfiles/vim/undo"
	ln -s ${HOME}/.config/dotfiles/vim "${HOME}/.vim"
	ln -s ${HOME}/.config/dotfiles/vim/vimrc "${HOME}/.vimrc"
	echo "\nbefore .vimrc.mine"
	$(MAKE) install_vim_plugins
	# note: install plugins before adding vimrc.mine, in case it has a dependence on the plugins
	$(MAKE) install_vimrc_mine

install_vimrc_mine: "${HOME}/.config/dotfiles/vim/vimrc.mine"

~/.config/dotfiles/vim/vimrc.mine:
	echo "\nin .vimrc.mine"
	cp etc/vimrc.mine vim/vimrc.mine
	cp etc/gvimrc.mine vim/gvimrc.mine

update_vim_plugins:
	vim +PlugUpdate

install_vim_plugins:
	# install and quit
	vim +PlugInstall +qall +slient


~/.tmux.conf:
	git clone git://github.com/nviennot/tmux-config.git "${HOME}/.tmux"
	cd "${HOME}/.tmux" && make install



install_zshrc: "${HOME}/.oh-my-zsh" "${HOME}/.zshrc"

~/.oh-my-zsh:
	installers/ohmyzsh
	# mkdir -p ${HOME}/.config/ohmy
	# curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o ${HOME}/.config/ohmy/install.sh
	# chmod a+x ${HOME}/.config/ohmy/install.sh
	# cd ${HOME}/.config/ohmy && ./install.sh
	# #sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	# # sudo chsh -s /usr/bin/zsh bmd

~/.zshrc:
	ln -s ${HOME}/.config/dotfiles/etc/zshrc ${HOME}/.zshrc



~/.rbenv:
	git clone https://github.com/sstephenson/rbenv.git "${HOME}/.rbenv"
	git clone https://github.com/sstephenson/ruby-build.git "${HOME}/.rbenv/plugins/ruby-build"
	grep rbenv $(SHELL_PROFILE) || [ $$? -eq 0 ]
	echo '------------------------------------------------'
	# cat rbenv-sh.txt >> $(SHELL_PROFILE)
	# $(MAKE) install_ruby_build

old_install_rubies:
	rbenv install 2.1.5
	rbenv global 2.1.5
	rbenv rehash

~/.irb:
	# see http://velvetpulse.com/2012/11/19/improve-your-ruby-workflow-by-integrating-vim-tmux-pry/
	git clone git://github.com/nviennot/irb-config.git "${HOME}/.irb"
	cd "${HOME}/.irb" && make install

~/.rbenv/shims/ruby:
	curl -sSL http://getrbenv.com/install | bash -s -- --rubies 2.1.5 --global-ruby 2.1.5 --plugins sstephenson/ruby-build,sstephenson/rbenv-gem-rehash
	#curl -sSL http://getrbenv.com/install | bash -s -- --rubies 2.1.5,2.2.2 --global-ruby 2.2.2 --plugins sstephenson/ruby-build,sstephenson/rbenv-gem-rehash
	# rbenv install --list
	# rbenv install 2.2.3
	rbenv rehash

build_all:
	sudo make root_install_user
	make force_install_spacemacs
	make force_relink
	sudo apt install -y emacs ssh zsh vim direnv mosh git curl

