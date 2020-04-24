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
        $HOME/code/chef \
        $HOME/code/chef/cookbooks \
    ; do
  # echo "path: $d"
  test -d $d && CDPATH="$d:$CDPATH"
done
CDPATH=".:$CDPATH"
export CDPATH

# ~/.chefdk/gem/ruby/2.5.0/bin \
PATH="/sbin"
for d in \
        ~/.config/binfiles \
        ~/.local/bin \
        ~/.linuxbrew \
        ~/.pyenv/bin \
        ~/.nodenv/bin \
        ~/.code/gocode/bin \
        ~/.cargo/bin \
        ~/.pkgs/packer \
        $HOME/code/mux/bin \
        $HOME/code/mux/tasks \
        $HOME/Library/Python/3.7/bin \
        /opt/local/bin \
        /opt/chef/embedded/bin \
        /opt/chef-workstation/embedded/bin \
        /opt/chef-workstation/bin \
        /opt/X11/bin \
        /usr/local/bin \
        /usr/bin \
        /bin \
        /usr/local/sbin \
        /usr/sbin \
        /snap/bin \
        /usr/local/share/npm/bin \
        /usr/local/go/bin \
        /usr/local/share/bin \
    ; do
  test -d $d && PATH="$d:$PATH"
done
export PATH

test -f "$HOME/.config/pw" && source $HOME/.config/pw
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# TODO: this is slow
if [ -d "${HOME}/.rbenv" ]; then
  export RBENV_ROOT="${HOME}/.rbenv"
  eval "$(rbenv init - --no-rehash zsh)"
fi

test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

#if [ -d ${HOME}/.pyenv ]; then
#  export PYENV_ROOT="${HOME}/.pyenv"
#  export PATH="$PATH:${PYENV_ROOT}/bin"
#  eval "$(pyenv init - zsh)"
#fi

# export TEST_KITCHEN_CPUS=6

export ANSIBLE_ROLES_PATH="./roles:../roles:../../roles"
export infrainv=~/code/ans/ttd-ansible/inventories/production/infraflow.yaml
export ANSIBLE_VAULT_KEY=~/.config/ansible_vault_key
