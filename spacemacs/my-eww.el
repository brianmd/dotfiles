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

