(provide 'my-term)

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

