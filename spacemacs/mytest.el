;; from Writing GNU Emacs Extensions, O'Reilly

(provide 'mytest)

(defun other-window-backward (&option n)
  "Select nth previous window."
  ;; p :: use prefix, if one was typed (C-u n), otherwise use 1
  (interactive "p")
  (if n
      (other-window (- n))
    (other-window -1)))

(defun other-window-backward2 (&option n)
  (interactive "p")
  (other-window (if n (- n) -1)))

(defun other-window-backward3 (&option n)
  (interactive "p")
  (other-window (or (- n) -1)))

(defun other-window-backward4 (&option n)
  (interactive "p")
  (other-window (- (or n 1))))

(defun other-window-backward5 (&option n)
  (interactive "P") ; note: capital P!!
  (other-window (- (prefix-numeric-value n))))

;; --------------------------------------------------------------

(defailais 'scroll-ahead 'scroll-up)
(defailais 'scroll-behind 'scroll-down)

(global-set-key "\C-x\C-q" 'quoted-insert)

;; --------------------------------------------------------------

write-file-hooks ;; list of functions to run whenever a buffer is saved
post-commmand-hooks ;; list of functions to run after every interactive command
find-file-hooks
buffer-file-name  ;; this is a buffer-local variable--different for each buffer

(defun read-only-if-symlink () ;; note: no param
  (if (file-symlink-p buffer-file-name)
      (progn
        (setq buffer-read-only t)
        (message "File is a symlink")
        )))
(add-hook 'find-file-hooks 'read-only-if-symlink)

(remove-hook 'find-file-hooks 'read-only-if-symlink)

;; anonymous function -- note: hard to remove-hook when lambda
(add-hook 'find-file-hooks
          '(lambda () ;; note: no param
             (if (file-symlink-p buffer-file-name)
                 (progn
                   (setq buffer-read-only t)
                   (message "File is a symlink")
                   ))))

;; --------------------------------------------------------------

(stringp buffer-file-name)
(when t
  (yes-or-no-p "question")
  (message "okay"))
(unless nil
  (yes-or-no-p "question")
  (message "okay"))

(setq buffer-read-only nil)
(file-symlink-p "~/.spacemacs") ;; returns nil or the filename symlink points to
(file-symlink-p "~/.config/dotfiles/etc/spacemacs")
(file-chase-links "~/.spacemacs")

;; loads another file into buffer
(find-alternate-file "~/.spacemacs")

(delete-file "~/junk.file") ;; error when file doesn't exist
(file-attributes buffer-file-name)
(file-modes buffer-file-name)
(file-executable-p buffer-file-name)
(file-directory-p buffer-file-name)
(file-chase-links "~/.spacemacs")
(file-expand-wildcards "~/.s*")
(file-name-base buffer-file-name)
;; (file-notify-add-watch buffer-file-name)
;; (file-notify-callback buffer-file-name)
;; (file-notify-rm-watch buffer-file-name)

;; important to test if buffer is even associated with a file!
(if buffer-file-name
    (message (format "this buffer is visiting file: %s" buffer-file-name))
  (message (format " this buffer is NOT associated with a file")))




;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
(error "my error message")
(message "hi")
(yes-or-no-p (format "Replace %s with %s? " "x" "y"))


;; --------------------------------------------------------------

(defadvice switch-to-buffer (before existing-buffer activate compile)
  "run before, name this advice 'existing-buffer, compile it and activate immediately
When interactive, switch to existing buffers only"
  ;; this replaces the original function's 'interactive
  ;; "b": accept only existing buffer names
  (interactive "b"))

(defadvice switch-to-buffer (before existing-buffer activate compile)
  "if a prefix (C-u) is given, the buffer doesn't have to exist"
  (interactive(let (read-buffer "Switch to buffer: "
                                (other-buffer)
                                (null current-prefix-arg)))))

;; --------------------------------------------------------------

this-command ;; *************************
last-command

;; note: defvar is set only-if variable isn't already set,
;;       otherwise it acts like `setq'
(defvar unscroll-to nil
  "Text position for next call to 'unscroll'.")
(point)

(goto-char 4065)

(window-edges)
(window-height)
(current-window-configuration)
(window-start)

(get-buffer-window "*Apropos*")
(previous-window)

(goto-char 4065) ;;**************************
(set-window-start nil 2955) ; nil => current window
(set-window-hscroll nil 5)
(set-window-hscroll nil 0)

;; --------------------------------------------------------------

(progn
  (put 'scroll-up 'unscrollable t)
  (put 'scroll-down 'unscrollable t)
  (put 'scroll-left 'unscrollable t)
  (put 'scroll-right 'unscrollable t)
  )
(get 'scroll-up 'unscrollable)
(get 'find-file 'unscrollable)

(defvar unscroll-point (make-marker)
  "Cursor position for next call to 'unscroll")

(set-marker unscroll-point (point))
(goto-char unscroll-point)

(set-marker unscroll-point nil)

;; --------------------------------------------------------------

;; leading '*' in doc string => user option
;; \\[insert-time] => replaced by key binding

(defvar insert-time-format "%X"
  "*Format for \\[insert-time] (c.f. 'format-time-string)")
(defvar insert-date-format "%x"
  "*Format for \\[insert-date] (c.f. 'format-time-string)")


;; interactive "*" => abort if read-only-buffer
(defun insert-time ()
  "Insert the current time according to insert-time-format"
  (interactive "*")
  (insert (format-time-string insert-time-format (current-time))))
(insert-time)

(defun insert-date ()
  "Insert the current date according to insert-date-format"
  (interactive "*")
  (insert (format-time-string insert-date-format (current-time))))
(insert-date)

;; --------------------------------------------------------------

(add-hook 'local-write-file-hooks 'update-writestamps)
(defun update-writestamps ()
  "Find writestamps and replace"
  (save-excursion ; save point
    (save-restriction ; save narrowing info (going to call widen to operate on entire file)
      (save-match-data ; save search data
    (widen)
       (goto-char (point-min))
       (while (search-forward (concat "write" "stamp((") nil t)
         (let ((start (point)))
           (search-forward "))")
           (delete-region start (- (point) 2))
           (goto-char start)
           (insert-time)
           (insert-date))))))
  nil)


writestamp((12:49:01 PM09/23/2017))

;; --------------------------------------------------------------


;; --------------------------------------------------------------

