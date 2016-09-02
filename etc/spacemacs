;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
    "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     auto-completion
     ;; ace-link
     better-defaults
     emacs-lisp
     git
     markdown
     clojure
     ruby
     ruby-on-rails
     (org :variables org-enable-github-support t)
     org
     (shell :variables
            shell-default-height 40
            shell-default-position 'bottom
            shell-default-shell 'multi-term
            shell-default-term-shell "/bin/zsh"
            )
     ;; spell-checking    -- produces error about missing helm file
     syntax-checking
     ;; version-control
     ;; osx
     gnus
     html
     dockerfile
     restclient
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(default-text-scale)
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. (default t)
   dotspacemacs-check-for-update t
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 5
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(
                         monokai
                         molokai
                         spolsky
                         tronesque
                         solarized-dark
                         spacemacs-dark
                         zenburn
                         zonokai-blue
                         )
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   ;; dotspacemacs-default-font '("Source Code Pro"
   dotspacemacs-default-font '("Mono"
                               :size 12
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; (Not implemented) dotspacemacs-distinguish-gui-ret nil
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)

   ;; if lose relative line numbers, can get them back with:
   ;; space : linum-mode
   dotspacemacs-line-numbers 'relative
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; unless file has a major mode, set mode to org-mode
   ;; major-mode 'org-mode
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init'.  You are free to put almost
any user code here.  The exception is org related code, which should be placed
in `dotspacemacs/user-config'."
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."
  (setq-default dotspacemacs-line-numbers 'relative)
  ;(define-key cider-minor-mode (kbd "C-e") 'cider-eval-defun-at-point)
  (global-set-key (kbd "C-e") 'cider-eval-defun-at-point)

  ;; unless file has a major mode, set mode to org-mode
  (setq-default major-mode 'org-mode)

  (setq helm-dash-common-docsets '("Redis"))

  ;; (setq org-capture-templates`(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
  ;;                               "* TODO %?\n  %i\n  %a")
  ;;                              ("j" "Journal" entry (file+datetree "~/org/journal.org")
  ;;                               "* %?\nEntered on %U\n  %i\n  %a")
  ;;                              ))

  (setq org-agenda-files (list
                               ;; "~/Dropbox/docs/org/gtd.org"
                               ;; "~/Dropbox/docs/org/work.org"
                               ;; "~/Dropbox/docs/org/home.org"
                               "~/Dropbox/docs/org/"
                               ))

  (if (string-equal "finch" (system-name))
      (set-face-attribute 'default nil :height 140)
      )

  (setq multi-term-program "/bin/zsh")
  (add-hook 'term-mode-hook
            (lambda ()
              (setq term-buffer-maximum-size 10000)
              (setq show-trailing-whitespace nil)
              ;; (autopair-mode -1)
              (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
              (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))
              (define-key term-raw-map (kbd "C-y") 'term-paste)
              ))
  (global-set-key (kbd "M-O") 'multi-term)

  (setq org-capture-templates
        '(("t" "GTD" entry (file+headline "~/Dropbox/docs/org/gtd.org" "GTD")
           "* TODO %?\n  %i\n  %a")
          ("w" "Work Journal" entry (file+datetree "~/Dropbox/docs/org/work-journal.org")
           "* %?")
          ("x" "Work Journal (extended entry)" entry (file+datetree "~/Dropbox/docs/org/work-journal.org")
           "* %?\nEntered on %U\n  %i\n  %a")
          ("j" "Journal" entry (file+datetree "~/Dropbox/docs/org/journal.org")
           "* %?\nEntered on %U\n  %i\n  %a")
          ))
  ;; the above uses these escapes
  ;; %a          annotation, normally the link created with org-store-link
  ;; %i          initial content, the region when capture is called with C-u.
  ;; %t, %T      timestamp, date only, or date and time
  ;; %u, %U      like above, but inactive timestamps

  ;; for org mode
  (setq org-bullets-bullet-list '("■" "◆" "▲" "▶"))

  (setq org-todo-keywords
        ;; cone and delegated are completed tasks; the others need further action
    '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED" "CANCELED")))

  (setq org-todo-keyword-faces
        '(("TODO" . (:foreground "red" :weight bold))
          ("FEEDBACK" . "yellow")
          ("CANCELED" . (:foreground "blue" :weight bold))
          ))

  ;; (with-eval-after-load
  ;;  'org
  ;  (setq org-agenda-files "/Users/bmd/.config/notes/"))


  ;; ;; Get email, and store in nnml
  ;; (setq gnus-secondary-select-methods
  ;;   '(
  ;;     (nntp "gmane" (nntp-address "news.gmane.org"))
  ;;     (nntp "news.eternal-september.org")
  ;;     (nntp "nntp.aioe.org")
  ;;     (nntp "news.gwene.org")
  ;;     (nnimap "gmail"
  ;;             (nnimap-address
  ;;              "imap.gmail.com")
  ;;             (nnimap-server-port 993)
  ;;             (nnimap-stream ssl))
  ;;     ))

  ;; ;; Send email via Gmail:
  ;; (setq message-send-mail-function 'smtpmail-send-it
  ;;       smtpmail-default-smtp-server "smtp.gmail.com")

  ;; ;; Archive outgoing email in Sent folder on imap.gmail.com:
  ;; (setq gnus-message-archive-method '(nnimap "imap.gmail.com")
  ;;       gnus-message-archive-group "[Gmail]/Sent Mail")

  ;; ;; set return email address based on incoming email address
  ;; (setq gnus-posting-styles
  ;;       ;; '(((header "to" "address@outlook.com")
  ;;       ;;    (address "address@outlook.com"))
  ;;         ((header "to" "brian@murphydye.com")
  ;;          (address "brian@murphydye.com"))
  ;;         ;; ((header "to" "bmdmailer@gmail.com")
  ;;         ;;  (address "bmdmailer@gmail.com"))
  ;;         )
      ;; )

  ;; ;; store email in ~/gmail directory
  ;; (setq nnml-directory "~/.config/gmail")
  ;; (setq message-directory "~/.config/gmail")



                                        ;(define-key cider-minor-mode (kbd "M-e") 'cider-eval-defun-at-point)
                                        ;(define-key cider-minor-mode (kbd "M-l") 'cider-eval-buffer)
                                        ;(setq clojure-enable-fancify-symbols t)

  ;; (unless window-system
  ;;   (global-set-key [mouse-4] 'scroll-down-line)
  ;;   (global-set-key [mouse-5] 'scroll-up-line))

  ;; (setq scroll-conservatively 101) ;; move minimum when cursor exits view, instead of recentering
  ;; (setq mouse-wheel-scroll-amount '(1)) ;; mouse scroll moves 1 line at a time, instead of 5 lines
  ;; (setq mouse-wheel-progressive-speed nil) ;; on a long mouse scroll keep scrolling by 1 line

  ;; (setq mouse-wheel-scroll-amount '(2 ((shift) . 1))) ;; two lines at a time
  ;; (setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
  ;; (setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

  ;; ( require 'smooth-scroll                        ) ;; Smooth scroll
  ;; ( smooth-scroll-mode 1                          ) ;; Enable it
  ;; ( setq smooth-scroll/vscroll-step-size 5        ) ;; Set the speed right

  (global-set-key (kbd "M-1") 'select-window-1)
  (global-set-key (kbd "M-2") 'select-window-2)
  (global-set-key (kbd "M-3") 'select-window-3)
  (global-set-key (kbd "M-4") 'select-window-4)
  (global-set-key (kbd "M-5") 'select-window-5)
  (global-set-key (kbd "M-6") 'select-window-6)
  (global-set-key (kbd "M-7") 'select-window-7)
  (global-set-key (kbd "M-8") 'select-window-8)
  (global-set-key (kbd "M-9") 'select-window-9)

  (global-set-key (kbd "M-l") 'evil-window-next)
  (global-set-key (kbd "M-h") 'evil-window-prev)
  (global-unset-key (kbd "M-j"))
  (global-set-key (kbd "M-j") 'evil-window-next)
  (global-set-key (kbd "M-k") 'evil-window-prev)

  ;; (define-key auto-highlight-symbol-mode-major-mode (kbd "M--") nil)
  ;; (local-unset-key "M--")
  ;; (global-unset-key (kbd "M--"))
  ;; (define-key minor-mode-map (kbd "M--") 'split-window-below-and-focus)
  ;; (define-key minor-mode-map (kbd "M-_") 'split-window-below-and-focus)
  ;; (global-set-key (kbd "M--") 'split-window-below-and-focus)
  ;; (local-set-key (kbd "M--") 'split-window-below-and-focus)
  ;; (global-set-key (kbd "M-_") 'split-window-below-and-focus)
  ;; (global-set-key (kbd "M-_") 'split-window-vertically)
  ;; (local-unset-key (kbd "M--"))
  ;; (local-unset-key "M--")
  ;; (local-unset-key "\M--")
  ;; (global-unset-key (kbd "M--"))
  (global-set-key (kbd "M--") 'split-window-below-and-focus)
  (global-set-key (kbd "M-\\") 'split-window-right-and-focus)
  (global-set-key (kbd "M-n") 'split-window-right-and-focus)
  (define-key (current-global-map) [remap ahs-back-to-start] 'split-window-below-and-focus)

  ;; these are M-left and M-right. These interfere with org mode
  ;; (define-key (current-global-map) [remap ahs-forward] 'evil-window-decrease-width)
  ;; (define-key (current-global-map) [remap ahs-backward] 'evil-window-increase-width)

  ;; (global-unset-key (kbd "M-<left>"))
  ;; (global-unset-key "\M-left")
  ;; (global-unset-key "\M-right")
  ;; (global-set-key (kbd "M-C-k") 'evil-window-decrease-height)
  ;; (global-set-key (kbd "M-C-j") 'evil-window-increase-height)
  ;; (global-set-key (kbd "M-C-h") 'evil-window-decrease-width)
  ;; (global-set-key (kbd "M-C-l") 'evil-window-increase-width)

  (global-set-key (kbd "C-M-=") 'default-text-scale-increase)
  (global-set-key (kbd "C-M--") 'default-text-scale-decrease)

  (spacemacs/set-leader-keys
    "oa" 'org-agenda
    "og" 'helm-org-agenda-files-headings
    "oi" 'org-clock-in
    "oo" 'org-clock-out
    "oc" 'org-capture
    "oC" 'helm-org-capture-templates ;requires templates to be defined.
    "ol" 'org-store-link
    "ot" 'org-toggle-checkbox
    "ov" 'cider-eval-defun-to-comment
    )

  ;; keybindings are exactly the same as in vimperator unless otherwise stated
  (evil-define-key 'normal eww-mode-map
    "\\" 'browse-url
    "&" 'eww-browse-with-external-browser ;; default in eww-mode
    "q" 'eww-quit ;; different in vimperator (run macro)
    "a" 'eww-add-bookmark
    "yy" 'eww-copy-page-url
    "f" 'eww-lnum-follow
    "F" 'eww-lnum-universal ;; in vimperator open new tab
    "gu" 'eww-up-url
    "gt" 'eww-top-url
    "f" 'eww-lnum-follow
    "F" 'eww-lnum-universal
    "h" 'eww-back-url ;; H in vimperator, because h is :help, but I think lowercase is better for us
    "l" 'eww-forward-url ;; in vimperator, L is used for consistency, but again I think lower case is nicer for us
    "r" 'eww-reload
    )

  ;; 'o' is like 'f' in cVIM (ace-link-eww)

  ;; Emacs Web Wowser   (note: evil-leader is ',')
  (evil-leader/set-key-for-mode 'eww-mode
    "ob"    'eww-add-bookmark
    "od"    'eww-download
    "oe"    'eww-browse-with-external-browser
    "og"    'eww-reload
    "oh"    'eww-back-url
    "ol"    'eww-forward-url
    "oq"    'eww-quit
    "ow"    'eww-copy-page-url
    "oB"    'eww-list-bookmarks
    "oH"    'eww-list-histories
    )

  (xterm-mouse-mode -1)
  (setq x-select-enable-clipboard t)
  (setq mouse-drag-copy-region t)
  ;; (define-key evil-normal-state-map "y" "\"+y")
  ;; (fset 'evil-visual-update-x-selection 'ignore)
  ;; (global-set-key (kbd "<mouse-2>") 'x-clipboard-yank)

  ;; this is what makes copy/paste work in terminal mode.
  ;; IMPORTANT: local and remote systems also need xsel
  ;; from https://hugoheden.wordpress.com/2009/03/08/copypaste-with-emacs-in-terminal/
  (unless window-system
   (when (getenv "DISPLAY")
    ;; Callback for when user cuts
    (defun xsel-cut-function (text &optional push)
      ;; Insert text to temp-buffer, and "send" content to xsel stdin
      (with-temp-buffer
        (insert text)
        ;; I prefer using the "clipboard" selection (the one the
        ;; typically is used by c-c/c-v) before the primary selection
        ;; (that uses mouse-select/middle-button-click)
        (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))
    ;; Call back for when user pastes
    (defun xsel-paste-function()
      ;; Find out what is current selection by xsel. If it is different
      ;; from the top of the kill-ring (car kill-ring), then return
      ;; it. Else, nil is returned, so whatever is in the top of the
      ;; kill-ring will be used.
      (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
        (unless (string= (car kill-ring) xsel-output)
	xsel-output )))
    ;; Attach callbacks to hooks
    ;; (setq interprogram-cut-function 'xsel-cut-function)
    ;; (setq interprogram-paste-function 'xsel-paste-function)
    ;; Idea from
    ;; http://shreevatsa.wordpress.com/2006/10/22/emacs-copypaste-and-x/
    ;; http://www.mail-archive.com/help-gnu-emacs@gnu.org/msg03577.html
   ))

  (defun ace-link-setup-default ()
    "Setup the defualt shortcuts."
    (eval-after-load "info"
      '(define-key Info-mode-map "o" 'ace-link-info))
    (eval-after-load "help-mode"
      '(define-key help-mode-map "o" 'ace-link-help))
    (eval-after-load "eww"
      '(progn
         (define-key eww-link-keymap "o" 'ace-link-eww)
         (define-key eww-mode-map "o" 'ace-link-eww))))

  (defun oleh-eww-hook ()
    (define-key eww-mode-map "j" 'oww-down)
    (define-key eww-mode-map "k" 'oww-up)
    (define-key eww-mode-map "l" 'forward-char)
    (define-key eww-mode-map "L" 'eww-back-url)
    (define-key eww-mode-map "h" 'backward-char)
    (define-key eww-mode-map "v" 'recenter-top-bottom)
    (define-key eww-mode-map "V" 'eww-view-source)
    (define-key eww-mode-map "m" 'eww-follow-link)
    (define-key eww-mode-map "a" 'move-beginning-of-line)
    (define-key eww-mode-map "e" 'move-end-of-line)
    (define-key eww-mode-map "o" 'ace-link-eww)
    (define-key eww-mode-map "y" 'eww))
  (add-hook 'eww-mode-hook 'oleh-eww-hook)
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(org-agenda-files   ;; these are set above
 ;;   (quote
 ;;    ("~/Dropbox/docs/org/gtd.org" "~/Dropbox/docs/org/gtd.org" "~/Dropbox/docs/org/journal.org")
 ;;    ))
 '(send-mail-function (quote mailclient-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
