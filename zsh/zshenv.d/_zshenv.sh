CDPATH="$HOME"
# put in reverse order of importanc
for d in \
        $HOME/code/ans \
        $HOME/code/docker \
        $HOME/pkgs \
        $HOME/pkgs/boxes \
        $HOME/Documents \
        $HOME/.config \
        $HOME/code/reference \
        $HOME/code/chef \
        $HOME/code/chef/cookbooks \
        $HOME/code/clojure \
        $HOME/code \
    ; do
  test -d "$d" && CDPATH="$d:$CDPATH"
done
CDPATH=".:$CDPATH"
export CDPATH

# ~/.chefdk/gem/ruby/2.5.0/bin \
# PATH="/sbin"
NEWPATH=""
for d in \
        ~/.config/binfiles \
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
        /snap/bin \
        /usr/local/share/npm/bin \
        /usr/local/go/bin \
        /usr/local/share/bin \
        ~/.local/bin \
        ~/.linuxbrew \
        /home/linuxbrew/.linuxbrew/bin \
        ~/.nodenv/bin \
        ~/.pyenv/bin \
        ~/.pyenv/shims \
        ~/.rbenv/shims \
    ; do
  test -d "$d" && NEWPATH="$d:$NEWPATH"
done
PATH=$NEWPATH
export PATH

# shellcheck source=../../../pw
# shellcheck disable=SC1091
test -f "$HOME/.config/pw" && source "$HOME/.config/pw"
# shellcheck source=../../../../.iterm2_shell_integration.zsh
# shellcheck disable=SC1091
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# TODO: this is slow
if [ -d "${HOME}/.rbenv" ]; then
  export RBENV_ROOT="${HOME}/.rbenv"
  eval "$(rbenv init - --no-rehash zsh)"
fi

if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  eval "$(pyenv init - zsh)"
fi

# test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
# test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# export TEST_KITCHEN_CPUS=6

export BID_CLUSTER_NODES="tor-cit200 lax-cit150 ukp-cit050 va1-cituser075 va1-citmap025 ca2-hi-abg35 cn2-cit-c5b1cd5 cn4-cit-db7754 de1-cit001 jp1-2-cit001 sg2-2-cit001 tor-aip025 lax-aip020 ukp-aip010"
export NON_BID_CLUSTER_NODES="use-cit-sgsk001 use-cit-cold001 use-cit-cxt001 cit-dedup001 cit-nie001 cit-ram001 cit-vid001"
export CLUSTER_NODES="$BID_CLUSTER_NODES $NON_BID_CLUSTER_NODES"
export ANSIBLE_ROLES_PATH="./roles:../roles:../../roles"
export infrainv=~/code/ans/ttd-ansible/inventories/production/infraflow.yaml
export ANSIBLE_VAULT_KEY=~/.config/ansible_vault_key

function ip { echo `ttdops list nodes --name "$1" --groupby internal_ip --summary --format json | jq '.[].internal_ip' | tr -d '"'` }
function s { ip=$(ip "$1"); shift; ssh "$ip" $@; }

setopt share_history
setopt inc_append_history
