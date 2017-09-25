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

;; save customizations from the UI (M-x customize) to its own file
(setq custom-file "~/.config/dotfiles/spacemacs/custom.el")
(load custom-file 'noerror)


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


