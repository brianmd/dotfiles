(provide 'my-fonts)

;;; Monaco font for programming (and some other modes)
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

(add-hook 'prog-mode-hook #’dh-set-monaco-font)
