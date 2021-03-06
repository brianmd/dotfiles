bindkey -v
bindkey -M viins 'fd' vi-cmd-mode

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

function zle-line-init zle-keymap-select {
}
function do_not_call_me {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    VIM_MAIN="%{$fg_bold[yellow]%} [% INSERT]%  %{$reset_color%}"
    VIM_VIINS="%{$fg_bold[yellow]%} [% VIINS  ]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/$VIM_MAIN}$(git_custom_status) $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=40

export TERM=xterm-256color
export LANG="en_US.UTF-8"
export EDITOR=vim
export VISUAL=vim
export GREP_COLOR='1;34'

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=(fg=blue)
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=(fg=red)

#custom key bindings
# VI MODE KEYBINDINGS (ins mode)
bindkey -M viins '^a'    beginning-of-line
bindkey -M viins '^e'    end-of-line
bindkey -M viins '^k'    kill-line
bindkey -M viins '^r'    history-incremental-pattern-search-backward
bindkey -M viins '^s'    history-incremental-pattern-search-forward
bindkey -M viins '^p'    up-line-or-history
bindkey -M viins '^n'    down-line-or-history
bindkey -M viins '^y'    yank
bindkey -M viins '^w'    backward-kill-word
bindkey -M viins '^u'    backward-kill-line
bindkey -M viins '^h'    backward-delete-char
bindkey -M viins '^?'    backward-delete-char
bindkey -M viins '^_'    undo
bindkey -M viins '^x^r'  redisplay
bindkey -M viins '\eOH'  beginning-of-line                 # Home
bindkey -M viins '\eOF'  end-of-line                       # End
bindkey -M viins '\e[2~' overwrite-mode                    # Insert
bindkey -M viins '\ef'   forward-word                      # Alt-f
bindkey -M viins '\eb'   backward-word                     # Alt-b
bindkey -M viins '\ed'   kill-word                         # Alt-d
bindkey -M viins '\e^h'  backward-kill-word                # Alt-backspace
bindkey -M viins '\e^?'  backward-kill-word                # Alt-backspace
bindkey -M viins 'jk'    vi-cmd-mode
bindkey -M viins '\e.'   insert-last-word

# VI MODE KEYBINDINGS (cmd mode)
bindkey -M vicmd '^a'    beginning-of-line
bindkey -M vicmd '^e'    end-of-line
bindkey -M vicmd '^k'    kill-line
bindkey -M vicmd '^r'    history-incremental-pattern-search-backward
bindkey -M vicmd '^s'    history-incremental-pattern-search-forward
bindkey -M vicmd '^p'    up-line-or-history
bindkey -M vicmd '^n'    down-line-or-history
bindkey -M vicmd '^y'    yank
bindkey -M vicmd '^w'    backward-kill-word
bindkey -M vicmd '^u'    backward-kill-line
bindkey -M vicmd '/'     vi-history-search-forward
bindkey -M vicmd '?'     vi-history-search-backward
bindkey -M vicmd '^_'    undo
bindkey -M vicmd '\ef'   forward-word                      # Alt-f
bindkey -M vicmd '\eb'   backward-word                     # Alt-b
bindkey -M vicmd '\ed'   kill-word                         # Alt-d
bindkey -M vicmd '\e[5~' history-beginning-search-backward # PageUp
bindkey -M vicmd '\e[6~' history-beginning-search-forward  # PageDown
bindkey -M vicmd '\e^h'  backward-kill-word                # Alt-backspace
bindkey -M vicmd '\e^?'  backward-kill-word                # Alt-backspace
bindkey -M vicmd '\e.'   insert-last-word

# open each file in its own tab (-p), splitting vertically (-o)
# alias v='vim -op'
set laststatus=1

