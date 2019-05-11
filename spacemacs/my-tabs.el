(provide 'my-tabs)

(defun my-setup-indent (n)
  ;; java/c/c++
  (setq c-basic-offset n)
  ;; web development
  (setq json-tab-width n)
  (setq ruby-tab-width n)
  (setq coffee-tab-width n) ; coffeescript
  (setq javascript-indent-level n) ; javascript-mode
  (setq js-indent-level n) ; js-mode
  (setq js2-basic-offset n) ; js2-mode, in latest js2-mode, it's alias of js-indent-level
  (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset n) ; web-mode, css in html file
  (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
  (setq css-indent-offset n) ; css-mode
  )

(defun set-indent (n)
  (setq-default
   c-basic-offset n
   coffee-tab-width n
   css-indent-offset n
   default-tab-width n
   evil-shift-width n
   javascript-indent-level n
   js2-basic-offset n
   js-indent-level n
   json-indent-level n
   prolog-indent-width n
   python-indent n
   python-indent-offset n
   ruby-indent n
   sh-indentation n
   standard-indent n
   tab-width n
   web-mode-attr-indent-offset n
   web-mode-code-indent-offset n
   web-mode-code-indent-offset n
   web-mode-css-indent-offset n
   web-mode-css-indent-offset n
   web-mode-markup-indent-offset n
   web-mode-markup-indent-offset n
   ))
(defun set-tab-width (n)
  (dolist (var '(evil-shift-width
                 default-tab-width
                 tab-width
                 c-basic-offset
                 cmake-tab-width
                 coffee-tab-width
                 cperl-indent-level
                 css-indent-offset
                 elixir-smie-indent-basic
                 enh-ruby-indent-level
                 erlang-indent-level
                 javascript-indent-level
                 js-indent-level
                 js2-basic-offset
                 js3-indent-level
                 lisp-indent-offset
                 livescript-tab-width
                 mustache-basic-offset
                 nxml-child-indent
                 perl-indent-level
                 puppet-indent-level
                 python-indent-offset
                 ruby-indent-level
                 rust-indent-offset
                 scala-indent:step
                 sgml-basic-offset
                 sh-basic-offset
                 web-mode-code-indent-offset
                 web-mode-css-indent-offset
                 web-mode-markup-indent-offset))
    (set (make-local-variable var) n)))

(set-indent 2)
(set-tab-width 2)
(add-hook 'shell-script-hook (lambda () (set-indent 2)))
