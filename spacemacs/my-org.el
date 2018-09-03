(provide 'my-org)

(require 'org)

(setq org-attach-directory "/home/bmd/Dropbox/docs/org/")
(setq-default org-attach-directory "/home/bmd/Dropbox/docs/org/")

(setq org-agenda-files (list
                        ;; "~/Dropbox/docs/org/gtd.org"
                        ;; "~/Dropbox/docs/org/work.org"
                        ;; "~/Dropbox/docs/org/home.org"
                        ;; "~/Dropbox/docs/org/"
                        "/home/bmd/Dropbox/docs/org/"
                        ))

(setq-default dotspacemacs-configuration-layers
             '((erc :variables
                    erc-server-list
                    '(("irc.freenode.net"
                       :port "6697"
                       :ssl t
                       :nick "some-user"
                       :password "secret")
                      ))))

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
    '((sequence "TODO" "FOCUS" "TODAY" "DOING" "DONE" "DELEGATED" "CANCELED")))
    ;; '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED" "CANCELED")))

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
  (find-file "~/Dropbox/docs/org/gtd.org"))
