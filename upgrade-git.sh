version=v2.14.1

echo 'install preconditions'
sudo yum groupinstall 'Development Tools'
sudo yum install -y perl-devel curl-devel expat-devel gettext-devel openssl-devel zlib-devel perl-ExtUtils-MakeMaker
# here is another version, if don't want to install development tools: sudo yum install autoconf cpio curl-devel expat-devel gcc gettext-devel make openssl-devel perl-ExtUtils-MakeMaker zlib-devel

cd /tmp
wget https://github.com/git/git/archive/${version}.tar.gz
cd git-$version

# leave prefix off, and git files will go to ~/bin
sudo make prefix=/usr/local/git all
sudo make prefix=/usr/local/git install

/usr/local/git/bin/git --version

echo 'need to add "/var/local/git/bin" to your PATH'
echo '   OR do the following (if you have not installed git via yum ...)'
# ln -sv /usr/local/git/bin/* /usr/bin/


