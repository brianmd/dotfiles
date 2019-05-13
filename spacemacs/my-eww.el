(provide 'my-eww)

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



;; http://oremacs.com/2014/12/30/ace-link-eww/

(defun oleh-eww-hook ()
  (define-key eww-mode-map "j" 'oww-down)
  (define-key eww-mode-map "k" 'oww-up)
  (define-key eww-mode-map "l" 'forward-char)
  (define-key eww-mode-map "L" 'eww-forward-url)
  (define-key eww-mode-map "h" 'backward-char)
  (define-key eww-mode-map "H" 'eww-back-url)
  (define-key eww-mode-map "v" 'recenter-top-bottom)
  (define-key eww-mode-map "V" 'eww-view-source)
  (define-key eww-mode-map "m" 'eww-follow-link)
  (define-key eww-mode-map "a" 'move-beginning-of-line)
  (define-key eww-mode-map "e" 'move-end-of-line)
  (define-key eww-mode-map "o" 'ace-link-eww)
  (define-key eww-mode-map "y" 'eww))
(add-hook 'eww-mode-hook 'oleh-eww-hook)

(defun oww-down (arg)
  (interactive "p")
  (if (bolp)
      (progn
        (forward-paragraph arg)
        (forward-line 1))
    (line-move arg)))

(defun oww-up (arg)
  (interactive "p")
  (if (bolp)
      (progn
        (forward-line -1)
        (backward-paragraph arg)
        (forward-line 1))
    (line-move (- arg))))

(defun ace-link-setup-default ()
  "Setup the default shortcuts."
  (eval-after-load "info"
    '(define-key Info-mode-map "o" 'ace-link-info))
  (eval-after-load "help-mode"
    '(define-key help-mode-map "o" 'ace-link-help))
  (eval-after-load "eww"
    '(progn
       (define-key eww-link-keymap "o" 'ace-link-eww)
       (define-key eww-mode-map "o" 'ace-link-eww))))

(ace-link-setup-default)



;; https://github.com/dakrone/eos/blob/master/eos-web.org
(use-package eww
  :defer t
  :init
  (setq browse-url-browser-function
        '((".*google.*maps.*" . browse-url-generic)
          ;; Github goes to firefox, but not gist
          ("http.*\/\/github.com" . browse-url-generic)
          ("groups.google.com" . browse-url-generic)
          ("docs.google.com" . browse-url-generic)
          ("melpa.org" . browse-url-generic)
          ("build.*\.elastic.co" . browse-url-generic)
          (".*-ci\.elastic.co" . browse-url-generic)
          ("internal-ci\.elastic\.co" . browse-url-generic)
          ("zendesk\.com" . browse-url-generic)
          ("salesforce\.com" . browse-url-generic)
          ("stackoverflow\.com" . browse-url-generic)
          ("apache\.org\/jira" . browse-url-generic)
          ("thepoachedegg\.net" . browse-url-generic)
          ("zoom.us" . browse-url-generic)
          ("t.co" . browse-url-generic)
          ("twitter.com" . browse-url-generic)
          ("\/\/a.co" . browse-url-generic)
          ("youtube.com" . browse-url-generic)
          ("amazon.com" . browse-url-generic)
          ("." . eww-browse-url)))
  (setq shr-external-browser 'browse-url-generic)
  (setq browse-url-generic-program (executable-find "firefox"))
  (add-hook 'eww-mode-hook #'toggle-word-wrap)
  (add-hook 'eww-mode-hook #'visual-line-mode)
  :config
  (use-package s :ensure t)
  (define-key eww-mode-map "o" 'eww)
  (define-key eww-mode-map "O" 'eww-browse-with-external-browser)
  (define-key eww-mode-map "j" 'next-line)
  (define-key eww-mode-map "k" 'previous-line)

  (use-package eww-lnum
    :ensure t
    :config
    (bind-key "f" #'eww-lnum-follow eww-mode-map)
    (bind-key "U" #'eww-lnum-universal eww-mode-map)))

(use-package link-hint
  :ensure t
  :bind ("C-c f" . link-hint-open-link))

(defun browse-last-url-in-brower ()
  (interactive)
  (save-excursion
    (ffap-next-url t t)))

(global-set-key (kbd "of") 'browse-last-url-in-brower) ;; firefox
(global-set-key (kbd "ob") 'browse-url-at-point)
