# TODO: .ssh/config, .ssh/keys
# TODO: add 'export VAGRANT_HOME=...' to a shared directory, then move
# ~/.vagrant.d there

KERNEL=`uname -s`
# to auto-update oh-my-zsh
export DISABLE_UPDATE_PROMPT=true

if [ -f ~/.config/pw ]; then
  source ~/.config/pw
fi

export DEFAULT_CONFIG_FILE='~/.redmine'

#    oh-my-zsh config
#
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

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

ZSH_THEME_HG_PROMPT_PREFIX="%{$fg_bold[magenta]%}hg:(%{$fg[red]%}"
ZSH_THEME_HG_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_HG_PROMPT_DIRTY="%{$fg[magenta]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_HG_PROMPT_CLEAN="%{$fg[magenta]%})"

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
plugins=(git bundler brew vagrant git-flow docker docker-compose docker-machine docker-local knife mercurial kitchen knife knife_ssh)
source $ZSH/oh-my-zsh.sh
source ~/.config/dotfiles/etc/git-sh.rc

if [ -n "$INSIDE_EMACS" ]; then
  export ZSH_THEME="rawsyntax"
else
    export ZSH_THEME="mortalscumbag"
    # override mortalscumbag's prompt to add mercurial output
    export PROMPT=$'\n$(ssh_connection)%{$fg_bold[green]%}%n@%m%{$reset_color%}$(my_git_prompt)$(hg_prompt_info) : %~\n[${ret_status}] %# '
fi

compctl -g '~/.teamocil/*(:t:r)' teamocil



# PROMPT='%3~$(git_prompt_info)%# '
#PROMPT='%3~$(git_prompt_info): '
#RPROMPT='$(git_time_since_commit)|$(git_custom_status)%{$fg[white]%}[node `node -v`]%{$reset_color%} $EPS1'

#PROMPT='%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} %{$fg[red]%}[%~% ] %B$%b '
#RPROMPT='$(git_time_since_commit)|$(git_custom_status) $EPS1'

alias k=kitchen
alias p='pgrep -af'

alias c='xclip -selection clipboard'
alias v='xclip -selection clipboard -o'

#ZSH_THEME_GIT_PROMPT_PREFIX="["
#ZSH_THEME_GIT_PROMPT_SUFFIX="]"

alias e="emacsclient -t -a ''"
alias eb="emacsbare"
# alias ec="emacsclient -c -n -a ''"
alias emacsbare="emacs -nw -Q --eval \"(load-theme 'misterioso)\""

alias n="DEBUG=* node --harmony"
alias ni="DEBUG=* node-debug --harmony"
alias bn="DEBUG=* babel-node --state 0"
# matching filenames
alias f="ag -g"

alias rs="rsync -ahP"

c() { cd ~/code/$1; }
_c() { _files -W ~/code -/; }
#compdef _c c

alias ipaddrs='ip addr list | grep "inet "'

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

alias s="ssh -AY"

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

# in emacs shell, type 'dt', then can run docker-compose
# from http://stackoverflow.com/questions/34928552/run-commands-on-docker-container-from-emacs
alias sc=systemctl
alias dt=". '/Applicaitons/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh'"
alias d=docker
alias dm=docker-machine
alias dc=docker-compose
function dmenv() { eval $(docker-machine env "$1") }

# export PATH="$HOME/bin:$HOME/.config/binfiles:$HOME/.rbenv/bin:$HOME/.rbenv/shims:/usr/local/bin:/usr/sbin:/sbin:$HOME/.local/bin:$HOME/.config/gocode/bin:$PATH"
export PATH="$HOME/bin:$HOME/.config/binfiles:/usr/local/bin:/usr/sbin:/sbin:$HOME/.local/bin:$HOME/.config/gocode/bin:$PATH"

export CDPATH=".:$HOME/code:$HOME/.config"
[ -d ~/code/docker ] && export CDPATH="$CDPATH:$HOME/code/docker"
[ -d ~/pkgs ] && export CDPATH="$CDPATH:$HOME/pkgs"
[ -d ~/pkgs/boxes ] && export CDPATH="$CDPATH:$HOME/pkgs/boxes"
export CDPATH="$CDPATH:$HOME"

export GOPATH=$HOME/.code/gocode

# export VAGRANT_DEFAULT_PROVIDER=vmware_fusion

if [ -d ${HOME}/code/summit ]; then
  export CDPATH=$CDPATH:$HOME/code/summit
fi

if [[ $KERNEL == 'Darwin' ]]; then
  keychain_cmd="ssh-add -K"
  #export SSL_CERT_FILE=/git/Certificates.pem
  export JAVA_HOME=`/usr/libexec/java_home`
  export PATH="$PATH:$HOME/Dropbox/summit/projects/summit-extensions/common/bin:/opt/local/bin:/usr/local/bin:/usr/local/share/npm/bin:$HOME/Dropbox/summit/bin:/usr/local/share/bin:/opt/local/bin:/opt/X11/bin:$HOME/.local/bin"
  export CDPATH=$CDPATH:~/Documents:~/Documents/git:~/Dropbox:~/Dropbox/summit:~/Dropbox/summit/projects:~/Documents/git/summit
else
  keychain_cmd=keychain
  # if [[ -f ~/.keychain/${HOST}-sh ]]; then source ~/.keychain/${HOST}-sh; fi
fi

if [[ -x $(which $keychain_cmd 2>/dev/null) ]]; then
  if [[ -f ~/.ssh/git_key ]]; then eval "$keychain_cmd ~/.ssh/git_key"; fi
  if [[ -f ~/.ssh/chrome ]]; then eval "$keychain_cmd ~/.ssh/chrome"; fi
  if [[ -f ~/.ssh/gru ]]; then eval "$keychain_cmd ~/.ssh/gru"; fi
  if [[ -f ~/.ssh/bmd-ttd ]]; then eval "$keychain_cmd ~/.ssh/bmd-ttd"; fi
  if [[ -f ~/.keychain/${HOST}-sh ]]; then source ~/.keychain/${HOST}-sh; fi
fi

if [[ -d ~/pkgs/packer ]]; then
  export PATH=$PATH:~/pkgs/packer
  export PACKER_CACHE_DIR=/usr/share/provisioners/packers
fi

if [[ -d /usr/local/go/bin ]]; then
  export PATH=$PATH:/usr/local/go/bin
fi

if type direnv > /dev/null; then
  # eval "$(direnv hook $0)"
  # eval "$(direnv hook $SHELL)"
  eval "$(direnv hook zsh)"
fi

if [ -n "$INSIDE_EMACS" ]; then
  echo "inside emacs, so will not load vim key bindings"
else
  source ~/.config/dotfiles/etc/vim-sh.rc
fi

# if [ -d ${HOME}/.rbenv ]; then
#   export RBENV_ROOT=${HOME}/.rbenv
#   eval "$(rbenv init - zsh)"
# fi

if [[ -d ~/.nodenv ]]; then
  export PATH="$HOME/.nodenv/bin:$PATH"
  eval "$(nodenv init -)"
fi

if [[ -d ~/.cargo/bin ]]; then
  export PATH="$PATH:$HOME/.cargo/bin"
fi

# export VAGRANT_HOME=/usr/share/provisioners/vagrant.d

# if &term =~ '256color'
  # set t_ut=
# fi


#  installing rbenv may add export RBENV_ROOT, PATH, and eval rbenv init.
#  These are already set above, so delete them from here

# added by travis gem
[ -f /Users/bmd/.travis/travis.sh ] && source /Users/bmd/.travis/travis.sh

export SHELL=`which zsh`
export EMAIL="bmdmailer@gmail.com"
export NAME="Brian Murphy-Dye"
export SMTPSERVER="smtp.gmail.com"

### Added by the Heroku Toolbelt
# export PATH="/usr/local/heroku/bin:$PATH"
# export RBENV_ROOT=/home/bmd/.rbenv
# export PATH=/home/bmd/.rbenv/bin:/home/bmd/.rbenv/shims:/home/bmd/.rbenv/bin:/home/bmd/.rbenv/shims:/home/bmd/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
# eval "$(rbenv init -)"
# export RBENV_ROOT=/home/bmd/.rbenv
# export PATH=/home/bmd/.rbenv/bin:/home/bmd/.rbenv/shims:/home/bmd/.rbenv/bin:/home/bmd/.rbenv/shims:/home/bmd/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
# eval "$(rbenv init -)"

# something sets xclip to a function, preventing /usr/bin/xclip from working
unset -f xclip

# The next line updates PATH for the Google Cloud SDK.
[ -f ~/.config/google-cloud-sdk/path.zsh.inc ] && source ~/.config/google-cloud-sdk/path.zsh.inc

# The next line enables shell command completion for gcloud.
[ -f ~/.config/google/cloud-sdk/completion.zsh.inc ] && source ~/.config/google-cloud-sdk/completion.zsh.inc

if [ -d /opt/chefdk/embedded/bin ]; then
  export PATH="/opt/chefdk/embedded/bin:$PATH"
  export TEST_KITCHEN=1
  eval "$(chef shell-init zsh)"
  alias cheflocal="chef-client --local-mode"
fi

[ -f ~/.config/dotfiles/etc/ttdrc ] && source ~/.config/dotfiles/etc/ttdrc

export CHEF_TEST_KITCHEN_ENCRYPTED_DBAG_SECRET_FILE=/home/bmd/.chef/databag-secret-kitchen.pem
export CHEF_SECRET=/home/bmd/.chef/databag-secret.pem

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

