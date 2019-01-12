(provide 'my-user-config)

(require 'my-clojure)
(require 'my-copy-paste)
(require 'my-dash-docsets)
;; (require 'my-eww)
(require 'my-mouse)
(require 'my-org)
(require 'my-tabs)
(require 'my-term)
(require 'my-windows)
(require 'narrow-or-widen)
;; (load "/home/bmd/.config/dotfiles/spacemacs/narrow-or-widen")

;; save customizations from the UI (M-x customize) to its own file
(setq custom-file "~/.config/dotfiles/spacemacs/custom.el")
(load custom-file 'noerror)

;; https://github.com/yjwen/org-reveal
;; git clone https://github.com/hakimel/reveal.js.git
;; (setq org-reveal-root "file:///data/data/com.termux/files/home/code/reveal.js")
;; (setq org-reveal-root "file:///home/bmd/code/reveal.js")
(setq org-reveal-root "file:///home/bmd/.config/dotfiles/docs/reveal.js")
(setq org-reveal-hlevel 1)

;; these were in the user-init

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

;; (message "done loading my-user-config")

(setq ranger-cleanup-eagerly t)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-0") 'text-scale-mode)

(setq org-ellipsis "⤵")


;; xoxp-10924691317-169530033073-189201081253-8c708f799095a5d0b364b13edb73a0a7

(slack-register-team
  :default t
  :name "thetradedesk"
  :client-id (getenv "SLACK_CLIENT")
  :client-secret (getenv "SLACK_SECRET")
  :token (getenv "SLACK_SECRET")
  :subscribed-channels '(general slackbot))

(add-to-list 'alert-user-configuration
  '(((:category . "slack")) ignore nil))

;; see http://endlessparentheses.com/keep-your-slack-distractions-under-control-with-emacs.html
;; and http://endlessparentheses.com/mold-slack-entirely-to-your-liking-with-emacs.html

(add-hook 'slack-mode-hook #'emojify-mode)

(add-to-list
  'alert-user-configuration
  '(((:title . "\\(dev-aerospike\\|dev-aerospike-trn\\)")
      (:category . "slack"))
     libnotify nil))

(add-to-list
  'alert-user-configuration
  '(((:message . "@brian\\|Brian")
      (:title . "\\(okchannel\\|sosochannel\\)")
      (:category . "slack"))
     libnotify nil))

; (spacemacs/set-leader-keys-for-major-mode 'clojure-mode "e;" 'cider-pprint-eval-defun-to-comment)
(spacemacs/set-leader-keys-for-major-mode 'clojure-mode "ec" 'cider-ppprint-eval-last-sexp-to-comment)

;; (evil-define-key 'normal clojure-mode-map (kbd ", e ;") 'cider-pprint-eval-defun-to-comment)

;; (add-hook 'clojure-mode-hook
;;           (lambda()
;;             (spacemacs/set-leader-keys-for-major-mode 'clojure-mode
;;               "ec" 'cider-pprint-eval-defun-to-comment)))
;; (spacemacs|use-package-add-hook clojure
;;   :post-config
;;   (spacemacs/set-leader-keys-for-major-mode 'clojure-mode
;;     "ec" 'cider-pprint-eval-defun-to-comment))
