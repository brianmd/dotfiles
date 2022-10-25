(spacemacs/set-leader-keys-for-major-mode 'clojure-mode (kbd "eq") 'cider-tap-last-sexp)
;; (evil-define-key 'normal cider-mode (kbd ", e q") 'cider-tap-last-sexp)
;; (evil-define-key 'normal cider-mode (kbd ", e t") 'cider-tap-sexp-at-point)

;; save customizations from the UI (M-x customize) to its own file
(setq custom-file "~/.config/dotfiles/spacemacs/custom.el")
(load custom-file 'noerror)

;; may need to do some setup before calling this?
(package-initialize)

(setq org-hide-emphasis-markers t)

(font-lock-add-keywords 'org-mode
                        '(("^ +\\([-*]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
;; (font-lock-add-keywords 'org-mode
;;                         '(("^ *\\([-]\\) "
;;                            (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(defun debug-msg (msg)
  (if t
    (message msg)))
(debug-msg "starting spacemacs init ...")

(defun load-if-exists (f)
  "load the elisp file only if it exists and is readable"
  (if (file-readable-p f)
      (load-file f)))

;; (load-if-exists "~/Sync/shared/mu4econfig.el")
;; (load-if-exists "~/Sync/shared/not-for-github.el")

;; Syntax highlight in #+BEGIN_SRC blocks
(setq org-src-fontify-natively t)
;; Don't prompt before running code in org
(setq org-confirm-babel-evaluate nil)

(debug-msg "clojure ...")

;; allow cursor past eol; useful for evaluating in clojure
;; (setq evil-move-cursor-back nil)
(setq evil-move-beyond-eol t)

;; by default (GET "/user/:id" [id]\n{:body ...}, body will align with /user/:id
;; (put-clojure-indent 'GET 2) ;; now always indent by 2

(global-set-key (kbd "C-e") 'cider-eval-defun-at-point)

;; (evil-define-key 'normal cider-mode (kbd ", e q") 'cider-tap-last-sexp)
;; (evil-define-key 'normal cider-mode (kbd ", e t") 'cider-tap-sexp-at-point)
;; (global-set-key (kbd ", e q") 'cider-tap-last-sexp)
;; (global-set-key (kbd ", e t") 'cider-tap-sexp-at-point)
;; (define-key cider-minor-mode (kbd ",eq") 'cider-tap-last-sexp)
;; (define-key cider-minor-mode (kbd ",et") 'cider-tap-sexp-at-point)

                                        ;(define-key cider-minor-mode (kbd "M-e") 'cider-eval-defun-at-point)
                                        ;(define-key cider-minor-mode (kbd "M-l") 'cider-eval-buffer)
                                        ;(setq clojure-enable-fancify-symbols t)
; (spacemacs/set-leader-keys-for-major-mode 'clojure-mode "e;" 'cider-pprint-eval-defun-to-comment)
(spacemacs/set-leader-keys-for-major-mode 'clojure-mode "ec" 'cider-ppprint-eval-last-sexp-to-comment)

;; (add-to-list 'exec-path "/home/zamansky/bin/")


;; (evil-define-key 'normal clojure-mode-map (kbd ", e ;") 'cider-pprint-eval-defun-to-comment)

;; (add-hook 'clojure-mode-hook
;;           (lambda()
;;             (spacemacs/set-leader-keys-for-major-mode 'clojure-mode
;;               "ec" 'cider-pprint-eval-defun-to-comment)))
;; (spacemacs|use-package-add-hook clojure
;;   :post-config
;;   (spacemacs/set-leader-keys-for-major-mode 'clojure-mode
;;     "ec" 'cider-pprint-eval-defun-to-comment))

(setq deft-directory "~/drop/notes")
(setq projectile-create-missing-test-files t)

(debug-msg "copy/paste ...")

  ; (shell-command-on-region (region-beginning) (region-end) "pbcopy")
  (cond
   ;; OS X
   ((string-equal system-type "darwin") ; Mac OS X
    (progn
      (setq save-to-clipboard-cmd "pbcopy")
      (setq paste-from-clipboard-cmd "pbpaste")
      )
    )
   ;; Linux
   ((string-equal system-type "gnu/linux") ; linux
    (progn
      (setq save-to-clipboard-cmd "xsel -i -b")
      (setq paste-from-clipboard-cmd "xsel -o -b")
      )
    )
   )
(defun copy-to-clipboard ()
  "Copies selection to x-clipboard."
  (interactive)
  (if (display-graphic-p)
      (progn
        (message "Yanked region to x-clipboard!")
        (call-interactively 'clipboard-kill-ring-save)
        )
    (if (region-active-p)
        (progn
          (shell-command-on-region (region-beginning) (region-end) save-to-clipboard-cmd)
          (message "Yanked region to clipboard!")
          (deactivate-mark))
      (message "No region active; can't yank to clipboard!")))
  )

(defun paste-from-clipboard ()
  "Pastes from x-clipboard."
  (interactive)
  (if (display-graphic-p)
      (progn
        (clipboard-yank)
        (message "graphics active")
        )
    (insert (shell-command-to-string paste-from-clipboard-cmd))
    )
  )
(evil-leader/set-key "o y" 'copy-to-clipboard)
(evil-leader/set-key "o p" 'paste-from-clipboard)

    (setq x-select-enable-clipboard t)
    ;; (setq mouse-drag-copy-region t)

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

(setq helm-dash-common-docsets '("Redis" "Ruby"))

(setq dired-dwim-target t)
(when (string= system-type "darwin")
  (setq dired-use-ls-dired nil))

(use-package dired-narrow
  :ensure t
  :config
  (bind-key "C-c C-n" #'dired-narrow)
  ;; ("bind-key C-c C-f" #'dired-narrow-fuzzy)
  (bind-key "C-x C-N" #'dired-narrow-regexp)
  )

(use-package dired-collapse
  :ensure t
  ;; :after dired
  :config
  ;; (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  ;; (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map)
  )
(add-hook 'dired-hook #'dired-collapse-mode)

(use-package dired-subtree
  :ensure t
  ;; :after dired
  :config
  (bind-key "i" #'dired-subtree-toggle dired-mode-map)
  ;; (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map))

;; this is a just-in-case I forget I'm already emacs
(defun eshell/emacs (file)
      (find-file file))
(defun eshell/vim (file)
      (find-file file))
(defun eshell/e (file)
      (find-file file))
(defun eshell/ee (file)
      (find-file-other-window file))

(defun eshell/gs () (git status))

;; from http://www.howardism.org/Technical/Emacs/eshell-fun.html
(defun eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))
(global-set-key (kbd "C-!") 'eshell-here)
(defun eshell/x ()
  (insert "exit")
  (eshell-send-input)
  (delete-window))


;; alias ll 'ls -l $*'
;; ls -al > #<buffer some-notes.org>

(require 'cl-lib)

;; from http://aaronbedra.com/emacs.d/
;; (require 'f)

(setq eshell-visual-commands
      '("less" "tmux" "htop" "top" "bash" "zsh" "fish"))

(setq eshell-visual-subcommands
      '(("git" "log" "l" "diff" "show")))

;; ;; Prompt with a bit of help from http://www.emacswiki.org/emacs/EshellPrompt
;; (defmacro with-face (str &rest properties)
;;   `(propertize ,str 'face (list ,@properties)))

;; (defun eshell/abbr-pwd ()
;;   (let ((home (getenv "HOME"))
;;         (path (eshell/pwd)))
;;     (cond
;;      ((string-equal home path) "~")
;;      ((f-ancestor-of? home path) (concat "~/" (f-relative path home)))
;;      (path))))

;; (defun eshell/my-prompt ()
;;   (let ((header-bg "#161616"))
;;     (concat
;;      (with-face (eshell/abbr-pwd) :foreground "#008700")
;;      (if (= (user-uid) 0)
;;          (with-face "#" :foreground "red")
;;        (with-face "$" :foreground "#2345ba"))
;;      " ")))

;; (setq eshell-prompt-function 'eshell/my-prompt)
;; (setq eshell-highlight-prompt nil)
;; (setq eshell-prompt-regexp "^[^#$\n]+[#$] ")

;; (setq eshell-cmpl-cycle-completions nil)

(spacemacs/set-leader-keys
  "obc" 'eyebrowse-create-window-config
  "obr" 'eyebrowse-rename-window-config
  "ob'" 'eyebrowse-last-window-config
  "ob." 'eyebrowse-switch-to-window-config

  "o0" 'eyebrowse-switch-to-window-config-0
  "o1" 'eyebrowse-switch-to-window-config-1
  "o2" 'eyebrowse-switch-to-window-config-2
  "o3" 'eyebrowse-switch-to-window-config-3
  "o4" 'eyebrowse-switch-to-window-config-4
  "o5" 'eyebrowse-switch-to-window-config-5
  "o6" 'eyebrowse-switch-to-window-config-6
  "o7" 'eyebrowse-switch-to-window-config-7
  "o8" 'eyebrowse-switch-to-window-config-8
  "o9" 'eyebrowse-switch-to-window-config-9
  )

(defalias 'yes-or-no-p 'y-or-n-p)

(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(message "Deleting old backup files...")
(let ((week (* 60 60 24 7))
      (current (float-time (current-time))))
  (dolist (file (directory-files temporary-file-directory t))
    (when (and (backup-file-name-p file)
               (> (- current (float-time (fifth (file-attributes file))))
                  week))
      (message "%s" file)
      (delete-file file))))

(debug-msg "fonts ...")
;;; Monaco font for programming (and some other modes)
;; from https://www.reddit.com/r/emacs/comments/73lplp/what_are_your_preferred_fonts_in_emacs/
(defvar dh-monaco-face-remapping-alist nil)

(when window-system
  (defface dh-default-monaco-face
    '((t (:family "Monaco" :inherit default)))
    "Default face with the Monaco font"
    :group 'basic-faces)

  (defface dh-bold-monaco-face
    '((t (:family "DejaVu Sans Mono" :inherit bold)))
    "Default bold face with the Monaco font"
    :group 'basic-faces)

  (defface dh-italic-monaco-face
    '((t (:family "DejaVu Sans Mono" :inherit italic)))
    "Default bold face with the Monaco font"
    :group 'basic-faces)

  (setq dh-monaco-face-remapping-alist
	'((default dh-default-monaco-face)
	  (bold dh-bold-monaco-face)
	  (italic dh-italic-monaco-face))))

(defun dh-set-monaco-font ()
  (setq-local face-remapping-alist dh-monaco-face-remapping-alist))

;; TODO the # sign causes an error, even though it is correct :(
;; (add-hook 'prog-mode-hook #’dh-set-monaco-font)

(debug-msg "indent tabs ...")
(setq-default indent-tabs-mode nil)

(setq-default show-trailing-whitespace t)
;; (defun set-indent (n)
;;   (setq-default
;;    c-basic-offset n
;;    coffee-tab-width n
;;    css-indent-offset n
;;    default-tab-width n
;;    evil-shift-width n
;;    javascript-indent-level n
;;    js2-basic-offset n
;;    js-indent-level n
;;    json-indent-level n
;;    json-tab-width n
;;    prolog-indent-width n
;;    python-indent n
;;    python-indent-offset n
;;    ruby-indent n
;;    ruby-tab-width n
;;    sh-indentation n
;;    standard-indent n
;;    tab-width n
;;    web-mode-attr-indent-offset n
;;    web-mode-code-indent-offset n
;;    web-mode-css-indent-offset n
;;    web-mode-markup-indent-offset n
;;    yaml-indent-offset n
;;    ))

(defun set-tab-width (n)
  (dolist (var '(
                 default-tab-width
                 c-basic-offset
                 cmake-tab-width
                 coffee-tab-width
                 cperl-indent-level
                 css-indent-offset
                 elixir-smie-indent-basic
                 enh-ruby-indent-level
                 erlang-indent-level
                 ess-indent-level
                 evil-shift-width
                 javascript-indent-level
                 js-indent-level
                 js2-basic-offset
                 js3-indent-level
                 json-indent-level
                 lisp-indent-offset
                 livescript-tab-width
                 mustache-basic-offset
                 nxml-child-indent
                 perl-indent-level
                 prolog-indedent-offset
                 puppet-indent-level
                 python-indent-offset
                 ruby-indent
                 ruby-indent-level
                 ruby-tab-width
                 rust-indent-offset
                 scala-indent:step
                 sgml-basic-offset
                 sh-basic-offset
                 sh-indentation
                 tab-width
                 web-mode-attr-indent-offset
                 web-mode-code-indent-offset
                 web-mode-css-indent-offset
                 web-mode-markup-indent-offset
                 yaml-indent-offset n
                 ))
    (set (make-local-variable var) n)))

;; (set-indent 2)
(set-tab-width 2)
(setq js-indent-level 2)
(add-hook 'shell-script-hook (lambda () (set-indent 2)))

(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (indent-buffer)
  (untabify-buffer)
  (delete-trailing-whitespace))

(defun cleanup-region (beg end)
  "Remove tmux artifacts from region."
  (interactive "r")
  (dolist (re '("\\\\│\·*\n" "\W*│\·*"))
    (replace-regexp re "" nil beg end)))

(global-set-key (kbd "C-x M-t") 'cleanup-region)
(global-set-key (kbd "C-c n") 'cleanup-buffer)

(global-visual-line-mode 1)

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

(add-hook 'compilation-finish-functions
  (lambda (buf strg)
    (switch-to-buffer-other-window "*compilation*")
    (read-only-mode)
    (goto-char (point-max))
    (local-set-key (kbd "q")
      (lambda () (interactive) (quit-restore-window)))))

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

(ace-link-setup-default)

(setq ranger-cleanup-eagerly t)

;; use SPC z f to increase/decrease font size
;; (global-set-key (kbd "C-=") 'text-scale-increase)
;; (global-set-key (kbd "C--") 'text-scale-decrease)
;; (global-set-key (kbd "C-0") 'text-scale-mode) ;; conflicts with mac goto-space-0

(debug-msg "mouse ...")
(when nil
;(unless window-system
  ;; (require 'mwheel)
  ;; (require 'mouse)
  ;; (xterm-mouse-mode t)
  ;; (mouse-wheel-mode t)
  ;; (global-set-key [mouse-4] 'next-line)
  ;; (global-set-key [mouse-5] 'previous-line)
  (global-set-key [mouse-4] 'scroll-down-line)
  (global-set-key [mouse-5] 'scroll-up-line)
  )

  ;; (setq scroll-conservatively 101) ;; move minimum when cursor exits view, instead of recentering
  ;; (setq mouse-wheel-scroll-amount '(1)) ;; mouse scroll moves 1 line at a time, instead of 5 lines
  ;; (setq mouse-wheel-progressive-speed nil) ;; on a long mouse scroll keep scrolling by 1 line

  ;; (setq mouse-wheel-scroll-amount '(2 ((shift) . 1))) ;; two lines at a time
  ;; (setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
  ;; (setq mouse-wheel-follow-mouse't) ;; scroll window under mouse

  ;; ( require 'smooth-scroll                        ) ;; Smooth scroll
  ;; ( smooth-scroll-mode 1                          ) ;; Enable it
  ;; ( setq smooth-scroll/vscroll-step-size 5        ) ;; Set the speed right

;; (xterm-mouse-mode -1)
;; ;; (setq x-select-enable-clipboard t)
;; (setq mouse-drag-copy-region t)

;; (setq transient-mark-mode t)

(defun narrow-or-widen-dwim (p)
  "Widen if buffer is narrowed, narrow-dwim otherwise.
Dwim means: region, org-src-block, org-subtree, or
defun, whichever applies first. Narrowing to
org-src-block actually calls `org-edit-src-code'.

http://endlessparentheses.com/emacs-narrow-or-widen-dwim.html

With prefix P, don't widen, just narrow even if buffer
is already narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning)
                           (region-end)))
        ((derived-mode-p 'org-mode)
         ;; `org-edit-src-code' is not a real narrowing
         ;; command. Remove this first conditional if
         ;; you don't want it.
         (cond ((ignore-errors (org-edit-src-code) t)
                (delete-other-windows))
               ((ignore-errors (org-narrow-to-block) t))
               (t (org-narrow-to-subtree))))
        ((derived-mode-p 'latex-mode)
         (LaTeX-narrow-to-environment))
        (t (narrow-to-defun))))

;; (define-key endless/toggle-map "n"
;;   #'narrow-or-widen-dwim)
;; This line actually replaces Emacs' entire narrowing
;; keymap, that's how much I like this command. Only
;; copy it if that's what you want.
;; (define-key ctl-x-map "n" #'narrow-or-widen-dwim)
(spacemacs/set-leader-keys
  "nn" 'narrow-or-widen-dwim)

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (define-key LaTeX-mode-map "\C-xn"
              nil)))

(debug-msg "org ...")
(require 'org)

(setq org-journal-dir "~/drop/notes/journal/")
(setq org-brain-path "~/drop/brain/")
(setq org-attach-directory "~/drop/notes/")
;; (setq-default org-attach-directory "~/drop/notes/")
(setq org-default-notes-file (concat org-directory "1.todo.org"))

(setq org-agenda-files (list
                        ;; "~/Dropbox/docs/org/gtd.org"
                        ;; "~/Dropbox/docs/org/work.org"
                        ;; "~/Dropbox/docs/org/home.org"
                        ;; "~/Dropbox/docs/org/"
                        "~/drop/notes"
                        ))

;; the following needs to be included with other layers in spacemacs file
;; (setq-default dotspacemacs-configuration-layers
;;              '((erc :variables
;;                     erc-server-list
;;                     '(("irc.freenode.net"
;;                        :port "6697"
;;                        :ssl t
;;                        :nick "some-user"
;;                        :password "secret")
;;                       ))))

(setq org-capture-templates
      '(("t" "GTD" entry (file+headline "~/drop/notes/gtd.org" "GTD")
         "* TODO %?\n  %i\n  %a")
        ("w" "Work Journal" entry (file+datetree "~/drop/notes/work-journal.org")
         "* %?")
        ("x" "Work Journal (extended entry)" entry (file+datetree "~/drop/notes/work-journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/drop/notes/journal.org")
         ;; "* %?\nEntered on %U\n  %i\n  %a")
         "* TODO %?\nEntered on %U")
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
    '((sequence "TODO" "FOCUS" "DOING" "|" "DONE" "DELEGATED" "CANCELED")))
    ;; '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED" "CANCELED")))

  (setq org-todo-keyword-faces
        '(("TODO" . (:foreground "red" :weight bold))
          ("FEEDBACK" . "yellow")
          ("CANCELED" . (:foreground "blue" :weight bold))
          ))

  ;; (with-eval-after-load
  ;;  'org
  ;  (setq org-agenda-files "/Users/bmd/.config/notes/"))



;; (require 'yafolding)



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
  "ow" 'add-work-entry
  "ox" 'add-extended-work-entry
  "mse" 'ruby-send-last-sexp
  "oz" 'find-gtd

  "of" 'yafolding-toggle-element

  "hw" 'sdcv-search-input
  )

(defun add-work-entry ()
  "add work journal entry"
  (interactive)
  (org-capture nil "w")
  (evil-append 1))

(defun add-extended-work-entry ()
  "add extended journal entry"
  (interactive)
  (org-capture nil "x")
  (evil-append 1))

(defun find-gtd ()
  (interactive)
  (find-file "~/drop/notes/gtd.org"))

; Set default column view headings: Task Total-Time Time-Stamp
(setq org-columns-default-format "%50ITEM(Task) %10CLOCKSUM %16TIMESTAMP_IA")

;; (require 'ob-browser)
(require 'ob-python)
;; (require 'ob-ipython)
(require 'ob-ruby)
(require 'ob-shell)

(org-babel-do-load-languages
 'org-babel-load-languages
 '( (emacs-lisp  . t)
    ;; (html . t)
    (js . t)
    (org . t)
    (python . t)
    ;; (ipython . t)
    ;; (r . t)
    (ruby . t)
    (shell . t)
    ))

;; https://github.com/yjwen/org-reveal
;; git clone https://github.com/hakimel/reveal.js.git
;; (setq org-reveal-root "file:///data/data/com.termux/files/home/code/reveal.js")
;; (setq org-reveal-root "file:///home/bmd/code/reveal.js")
;; (setq org-reveal-root "file:///home/bmd/.config/dotfiles/docs/reveal.js")
(setq org-reveal-root "~/.config/dotfiles/docs/reveal.js")
(setq org-reveal-hlevel 1)
(setq org-ellipsis "⤵")

;; xoxp-10924691317-169530033073-189201081253-8c708f799095a5d0b364b13edb73a0a7

(require 'seeing-is-believing)
(add-hook 'ruby-mode-hook 'seeing-is-believing)

(add-hook 'ruby-mode-hook
          (lambda () (hs-minor-mode)))

(eval-after-load "hideshow"
  '(add-to-list 'hs-special-modes-alist
                `(ruby-mode
                  ,(rx (or "def" "class" "module" "do" "{" "[")) ; Block start
                  ,(rx (or "}" "]" "end"))                       ; Block end
                  ,(rx (or "#" "=begin"))                        ; Comment start
                  ruby-forward-sexp nil)))

(global-set-key (kbd "C-c h <left>") 'hs-hide-block)
(global-set-key (kbd "C-c h <right>") 'hs-show-block)

(global-set-key (kbd "C-c h <up>") 'hs-hide-level)

;; (require 'yafolding)
(add-hook 'ruby-mode-hook 'yafolding-mode)
;; (global-set-key (kbd "M-RET")   'yafolding-toggle-element)
(spacemacs/set-leader-keys
  "of" 'yafolding-toggle-element
  )

(debug-msg "terminal ...")
;; term shortcuts
;; (add-to-list 'term-mode-hook
;;              (lambda ()
;;                     (define-key term-raw-map (kbd "C-y") 'term-paste)))
;; http://rawsyntax.com/blog/learn-emacs-zsh-and-multi-term/
(add-hook 'term-mode-hook
          (lambda ()
            (setq term-buffer-maximum-size 10000)
            (setq show-trailing-whitespace nil)
            ;; (autopair-mode -1)
            ;; (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
            ;; (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))
            ;; (define-key term-raw-map (kbd "C-y") 'term-paste)
            ))

;; (global-set-key (kbd "M-O") 'multi-term)

;; (global-set-key (kbd "C-c C-j") 'term-line-mode)

;; http://paralambda.org/2012/07/02/using-gnu-emacs-as-a-terminal-emulator/
;; (setq term-bind-key-alist
;;       (list
;;        (cons "C-c C-c" 'term-interrupt-subjob)
;;        (cons "C-p" 'previous-line)
;;        (cons "C-n" 'next-line)
;;        (cons "M-f" 'term-send-forward-word)
;;        (cons "M-b" 'term-send-backward-word)
;;        (cons "C-c C-j" 'term-line-mode)
;;        (cons "C-c C-k" 'term-char-mode)
;;        (cons "M-DEL" 'term-send-backward-kill-word)
;;        (cons "M-d" 'term-send-forward-kill-word)
;;        (cons "<C-left>" 'term-send-backward-word)
;;        (cons "<C-right>" 'term-send-forward-word)
;;        ;; (cons "C-r" 'term-send-reverse-search-history)
;;        (cons "M-p" 'term-send-raw-meta)
;;        (cons "M-y" 'term-send-raw-meta)
;;        (cons "C-y" 'term-send-raw)
;;        ))

(setq multi-term-program "/usr/bin/zsh")

(setq tramp-default-method "ssh")

(setq delete-by-moving-to-trash t)

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
;; (global-set-key (kbd "M-n") 'split-window-right-and-focus)
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

(global-set-key (kbd "C-M-=") 'text-scale-increase)
(global-set-key (kbd "C-M--") 'text-scale-decrease)
;; (global-set-key (kbd "C-M-=") 'default-text-scale-increase)
;; (global-set-key (kbd "C-M--") 'default-text-scale-decrease)

(debug-msg "all done ...")
