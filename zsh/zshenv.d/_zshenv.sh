CDPATH="$HOME"
for d in \
    $HOME/code/ans \
        $HOME/code/docker \
        $HOME/code \
        $HOME/.config \
        $HOME/code/reference \
        $HOME/pkgs \
        $HOME/pkgs/boxes \
        $HOME/Documents \
    ; do
    test -d $d && CDPATH="$d:$CDPATH"
done
export CDPATH

# ~/.chefdk/gem/ruby/2.5.0/bin \
PATH="/sbin"
for d in \
    z \
        ~/.config/binfiles \
        ~/.local/bin \
        ~/.linuxbrew \
        ~/.pyenv/bin \
        ~/.nodenv/bin \
        ~/.code/gocode/bin \
        ~/.cargo/bin \
        ~/.pkgs/packer \
        /usr/local/share/npm/bin \
        /usr/local/go/bin \
        /usr/local/share/bin \
        /opt/local/bin \
        /opt/chefdk/embedded/bin \
        /opt/X11/bin \
        /usr/local/bin \
        /usr/bin \
        /bin \
        /usr/local/sbin \
        /usr/sbin \
        /snap/bin \
    ; do
    test -d $d && PATH="$d:$PATH"
done
export PATH

test -f "$HOME/.config/pw" && source $HOME/.config/pw



#if [ -d ${HOME}/.pyenv ]; then
#  export PYENV_ROOT="${HOME}/.pyenv"
#  export PATH="$PATH:${PYENV_ROOT}/bin"
#  eval "$(pyenv init - zsh)"
#fi
