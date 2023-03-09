# Note: zshrc runs after zshenv

# TODO: .ssh/config, .ssh/keys
# TODO: add 'export VAGRANT_HOME=...' to a shared directory, then move
# $HOME/.vagrant.d there
#
# may use '*' in history search, not regex

# shellcheck source=/dev/null
test -f ~/.fzf.zsh && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

KERNEL=$(uname -s)
# to auto-update oh-my-zsh
export DISABLE_UPDATE_PROMPT=true
export DISABLE_AUTO_TITLE=true
# alias settitle="echo -e \"\033];$1\007\""
settitle() { echo -e "\033];$1\007" }

export DEFAULT_CONFIG_FILE="$HOME/.redmine"

#    oh-my-zsh config
#
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
export SAVEHIST=20000

#ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
ZSH_THEME="flazz"
ZSH_THEME="blinks"
ZSH_THEME="alanpeabody"
ZSH_THEME="avit"
ZSH_THEME="sunrise"
ZSH_THEME="bureau"
ZSH_THEME="cloud"
ZSH_THEME="muse"
ZSH_THEME="mortalscumbag"

export ZSH_THEME_HG_PROMPT_PREFIX="%{$fg_bold[magenta]%}hg:(%{$fg[red]%}"
export ZSH_THEME_HG_PROMPT_SUFFIX="%{$reset_color%}"
export ZSH_THEME_HG_PROMPT_DIRTY="%{$fg[magenta]%}) %{$fg[yellow]%}✗%{$reset_color%}"
export ZSH_THEME_HG_PROMPT_CLEAN="%{$fg[magenta]%})"

# http://oblalex.blogspot.com/2013/06/extending-oh-my-zsh-with-hgprompt.html
# https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/mortalscumbag.zsh-theme

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby gem lighthouse)
# plugins=(git bundler brew vagrant git-flow docker docker-compose docker-machine knife mercurial kitchen knife knife_ssh kubectl mosh systemd vi-mode fzf)
# Could add:
#   brew, adds aliases for brew
plugins=(git bundler docker docker-compose docker-machine kubectl mosh systemd vi-mode fzf)
# shellcheck source=/dev/null
source "$ZSH/oh-my-zsh.sh"
# shellcheck source=/dev/null
export XDG_CONFIG_HOME="$HOME/.config"
source "$HOME/.config/dotfiles/etc/git-sh.rc"

if [ -n "$INSIDE_EMACS" ]; then
  export ZSH_THEME="rawsyntax"
else
    export ZSH_THEME="mortalscumbag"
    # override mortalscumbag's prompt to add mercurial output
    export PROMPT=$'\n$(ssh_connection)%{$fg_bold[green]%}%n@%m%{$reset_color%}$(my_git_prompt)$(hg_prompt_info) : %~\n[${ret_status}] %# '
fi

compctl -g '$HOME/.teamocil/*(:t:r)' teamocil

# to prevent going to a directory without typing 'cd'
unsetopt AUTO_CD


# PROMPT='%3~$(git_prompt_info)%# '
#PROMPT='%3~$(git_prompt_info): '
#RPROMPT='$(git_time_since_commit)|$(git_custom_status)%{$fg[white]%}[node `node -v`]%{$reset_color%} $EPS1'

#PROMPT='%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} %{$fg[red]%}[%~% ] %B$%b '
#RPROMPT='$(git_time_since_commit)|$(git_custom_status) $EPS1'

alias k=kubectl
alias kns='kubectl config set-context $(kubectl config current-context) --namespace '
# alias p='pgrep -af'

alias c='xclip -selection clipboard'
alias v='xclip -selection clipboard -o'

#ZSH_THEME_GIT_PROMPT_PREFIX="["
#ZSH_THEME_GIT_PROMPT_SUFFIX="]"

alias e='emacsclient -t -a ""'
alias eb="emacsbare"
# alias ec="emacsclient -c -n -a ''"
alias emacsbare="emacs -nw -Q --eval \"(load-theme 'misterioso)\""

alias n="DEBUG=* node --harmony"
alias ni="DEBUG=* node-debug --harmony"
alias bn="DEBUG=* babel-node --state 0"
# matching filenames
test -f /usr/local/bin/fd && alias f="/usr/local/bin/fd"
test -f /opt/homebrew/bin/fd && alias f="/opt/homebrew/bin/fd"
test -f /bin/fd && alias f="/bin/fd"
test -f /usr/local/bin/trash && alias rm="/usr/local/bin/trash"

alias ag1="ag --depth 1"
alias rs="rsync -ahP"

# bmd c() { cd "$HOME/code/$1"; }
# bmd _c() { _files -W "$HOME/code" -/; }
#compdef _c c

alias ipaddrs="ifconfig | awk '/inet / {print \$2}'"

alias myip="ip -br -c a"
alias os='cat /etc/*release*'
alias restart='sudo systemctl restart'
alias start='sudo systemctl start'
alias stop='sudo systemctl stop'

# trello
alias inbox="trellor todo inbox"
alias inprogress="trellor todo inprogress"
alias home="trellor home inbox"
alias 5001="trellor home 5001"
alias sinbox="trellor 'feature/20-20' 'To'"

alias xt='xterm -fg white -bg black'
#alias tmux='direnv exec / tmux'
alias tmux="tmux -2"
alias t="tmux"
alias tls="tmux list-sessions"
alias td="tmux detach"
alias ta="tmux attach-session -t"
#alias tn="tmux new-window ; tmux rename-window"
alias tn="tmux new"
alias tp="tmux split-window"
alias tu="tmux switch-pane -U"

alias b="bundle"
alias bi="b install --path vendor"
alias bil="bi --local"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package"
alias bev="b exec vagrant"

# alias s="ssh -AY"

alias reload="source ~/.zshrc"
alias config="subl ~/.zshrc"
#alias setup="subl ~/.bashrc && reload"

# digitalocean tool
alias doc="doctl compute"
alias dod="doctl compute droplet"
alias dos="doctl compute ssh"

# Heroku
alias hconfig="heroku config"
alias hlogs="heroku logs"
alias hps="heroku ps"
alias hrun="heroku run"

# Vagrant
#alias v="vagrant"
#alias vd="vagrant --provider=digital_ocean"
alias va="vagrant"
alias vs="vagrant ssh"
alias vu="vagrant up"
alias vd="vagrant destroy"
alias vh="vagrant halt"
alias vstat="vagrant status"

# Redis
alias redismd="redis-cli -h redis-md -p 11510 -a '$REDIS_MD_PW'"

#aliases
alias 1='cd ../'
alias 2='cd ../../'
alias 3='cd ../../../'
alias 4='cd ../../../../'

alias da='direnv allow'

alias l=logit

# in emacs shell, type 'dt', then can run docker-compose
# from http://stackoverflow.com/questions/34928552/run-commands-on-docker-container-from-emacs
alias dt=". '/Applicaitons/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh'"
alias sc=systemctl
alias d=docker
alias dm=docker-machine
alias dc=docker-compose
# function dmenv() { eval $(docker-machine env "$1") }
alias p=podman
alias pm=podman machine

# export VAGRANT_DEFAULT_PROVIDER=vmware_fusion

if [[ $KERNEL == 'Darwin' ]]; then
  #keychain_cmd="ssh-add -K --quiet"
  #keychain_cmd="keychain --quiet"
  keychain_cmd="keychain"
  #export SSL_CERT_FILE=/git/Certificates.pem
  JAVA_HOME=$(/usr/libexec/java_home)
  export JAVA_HOME
  ulimit -n 2048
else
  # keychain_cmd="keychain --quiet"
  keychain_cmd="keychain"
  # if [[ -f "$HOME/.keychain/${HOST}-sh" ]]; then source "$HOME/.keychain/${HOST}-sh"; fi
fi

if [[ -x $(which $keychain_cmd 2>/dev/null) ]]; then
  if [[ -f "$HOME/.ssh/git_key" ]]; then eval "$keychain_cmd $HOME/.ssh/git_key"; fi
  if [[ -f "$HOME/.ssh/chrome" ]]; then eval "$keychain_cmd $HOME/.ssh/chrome"; fi
  if [[ -f "$HOME/.ssh/ttd-vault" ]]; then eval "$keychain_cmd $HOME/.ssh/ttd-vault"; fi
  if [[ -f "$HOME/.ssh/gru" ]]; then eval "$keychain_cmd $HOME/.ssh/gru"; fi
  if [[ -f "$HOME/.ssh/bmd-ttd" ]]; then eval "$keychain_cmd $HOME/.ssh/bmd-ttd"; fi
  # shellcheck source=/dev/null
  if [[ -f "$HOME/.keychain/$HOST-sh" ]]; then source "$HOME/.keychain/$HOST-sh"; fi
fi

if [ -n "$INSIDE_EMACS" ]; then
  echo "inside emacs, so will not load vim key bindings"
else
  # EDITOR can only be an executable -- no args
  # export EDITOR='/usr/bin/emacsclient -t -a ""'
  export EDITOR=emacsclient
  export EDITOR=vim
fi

# export VAGRANT_HOME=/usr/share/provisioners/vagrant.d

# if &term =~ '256color'
  # set t_ut=
# fi


# added by travis gem
# shellcheck source=/dev/null
test -f /Users/bmd/.travis/travis.sh && source /Users/bmd/.travis/travis.sh

SHELL=$(which zsh)
export SHELL
export EMAIL="bmdmailer@gmail.com"
export NAME="Brian Murphy-Dye"
export SMTPSERVER="smtp.gmail.com"

# something sets xclip to a function, preventing /usr/bin/xclip from working
# bmd unset -f xclip

# The next line enables shell command completion for gcloud.
# shellcheck source=/dev/null
[ -f "$HOME/.config/google/cloud-sdk/completion.zsh.inc" ] && source "$HOME/.config/google-cloud-sdk/completion.zsh.inc"

[ -f "$HOME/.config/dotfiles/etc/ttdrc" ] && source "$HOME/.config/dotfiles/etc/ttdrc"

# export CHEF_TEST_KITCHEN_ENCRYPTED_DBAG_SECRET_FILE=/home/bmd/.chef/databag-secret-kitchen.pem
# export CHEF_SECRET=/home/bmd/.chef/databag-secret.pem

export CHEF_TEST_KITCHEN_ENCRYPTED_DBAG_SECRET_FILE="$HOME/.chef/databag-secret-kitchen.pem"
export CHEF_SECRET="$HOME/.chef/databag-secret.pem"

export opsinventory=$HOME/code/mux/bin/opsinventory.py
#export opinv=$HOME/code/mux/bin/opsinventory.py
export oinv=$HOME/code/mux/bin/opsinventory.py
# export opsinv=$HOME/code/ans/ttd-ansible/inventories/ops-inventory.py
alias apl="ansible-playbook -i $oinv"
alias ans="ansible -i $oinv"
function osh { host=$1; shift; ssh brian.murphy-dye@"$($oinv --ip $host)" -o StrictHostKeyChecking=no "$@";  }

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# export PATH="$PATH:/snap/bin"
# export  ANSIBLE_VAULT_PASSWORD_FILE="./.vault_key" # use ANSIBLE_VAULT_KEY in ~/.ansible.cfg, and override that in .envrc files



# if [[ $KERNEL == 'Darwin' ]]; then


test -d "$HOME/pkgs/packer" && export PACKER_CACHE_DIR=/usr/share/provisioners/packers

test "$(which bat >/dev/null)" && alias cat=bat
test "$(which prettyping >/dev/null)" && alias ping='prettyping --nolegend'
test "$(which tldr >/dev/null)" && alias help=man || alias help=tldr
test "$(which fd >/dev/null)" && alias fii=find || alias fii=fd


if type direnv > /dev/null; then
    # eval "$(direnv hook $0)"
    # eval "$(direnv hook $SHELL)"
    eval "$(direnv hook zsh)"
fi


#if [ -d /opt/chefdk/embedded/bin ]; then
#    export TEST_KITCHEN=1
#    # export TEST_KITCHEN_CPUS=6
# TODO: this is slow
#    eval "$(chef shell-init zsh --no-rehash)"
#    alias cheflocal="chef-client --local-mode"
#fi

if [[ -d "$HOME/.nodenv" ]]; then
    eval "$(nodenv init -)"
fi

if [ -d "${HOME}/.pyenv" ]; then
    export PYENV_ROOT="${HOME}/.pyenv"
    eval "$(pyenv init - zsh)"
fi

# test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
# test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# TODO: this is slow
# moved to zshenv
# if [ -d ${HOME}/.rbenv ]; then
#     export PATH="$HOME/.rbenv/bin:$PATH"
#     export RBENV_ROOT=${HOME}/.rbenv
#     # eval "$(rbenv init - zsh --no-rehash)"
#     eval "$(rbenv init -)"
# fi

if [ -d "${HOME}/.rbenv" ]; then
  export RBENV_ROOT="${HOME}/.rbenv"
  eval "$(rbenv init - --no-rehash zsh)"
fi

[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

# The next line updates PATH for the Google Cloud SDK.
# shellcheck source=/dev/null
[ -f "$HOME/.config/google-cloud-sdk/path.zsh.inc" ] && source "$HOME/.config/google-cloud-sdk/path.zsh.inc"

#  installing rbenv may add export RBENV_ROOT, PATH, and eval rbenv init.
#  These are already set above, so delete them from here

function s2a { eval $( $(which saml2aws) script --shell=bash --profile=$@); }

setconsul () {
  if [ ":" = ":$CONSUL_DEV_TOKEN" ]; then
    echo "CONSUL_DEV_TOKEN must be set"
    return 1
  elif [ ":" = ":$CONSUL_QA_TOKEN" ]; then
    echo "CONSUL_QA_TOKEN must be set"
    return 1
  fi

  if [ ":$1" = ":dev" ]; then
    export CONSUL_TOKEN="$CONSUL_DEV_TOKEN"
  elif [ ":$1" = ":qa" ]; then
    export CONSUL_TOKEN="$CONSUL_QA_TOKEN"
  else
    echo "Must pass either 'dev' or 'qa'"
    return 1
  fi

  export CONSUL_ENV=$1
  export CONSUL_HTTP_ADDRESS="https://$1.consul.multipass.comcast.com"

  # for ops/bin/start.sh:
  export CONSUL_HOST="https://$1.consul.multipass.comcast.com"
  export ENV=$1

  echo "CONSUL_ENV=$CONSUL_ENV"
  echo "CONSUL_HTTP_ADDRESS=$CONSUL_HTTP_ADDRESS"
  # echo "CONSUL_TOKEN=$CONSUL_TOKEN"
  echo "CONSUL_TOKEN is set for $CONSUL_ENV"
}
