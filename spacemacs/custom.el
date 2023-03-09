(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(custom-safe-themes
   '("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default))
 '(ignored-local-variable-values
   '((eval
      (lambda nil
        (defun cider-jack-in-wrapper-function
            (orig-fun &rest args)
          (if
              (and
               (boundp 'use-bb-dev)
               use-bb-dev)
              (message "Use `bb dev` to start the development server, then `cider-connect` to the port it specifies.")
            (apply orig-fun args)))
        (advice-add 'cider-jack-in :around #'cider-jack-in-wrapper-function)
        (when
            (not
             (featurep 'clerk))
          (let
              ((init-file-path
                (expand-file-name "clerk.el" default-directory)))
            (when
                (file-exists-p init-file-path)
              (load init-file-path)
              (require 'clerk))))))
     (use-bb-dev . t)
     (prettify-symbols-mode)))
 '(package-selected-packages
   '(jinja2-mode company-ansible ansible-doc ansible gmail-message-mode ham-mode html-to-markdown flymd edit-server vterm ess-smart-equals ess-R-data-view ctable ess julia-mode helm-dash dash-docs dash-at-point yasnippet-snippets seeing-is-believing org-brain erc-terminal-notifier enh-ruby-mode try log4j-mode logview datetime extmap vlf sdcv showtip dired-subtree dired-narrow dired-collapse dired-hacks-utils yaml-mode slack emojify circe oauth2 websocket ht insert-shebang flyspell-correct-helm flyspell-correct fish-mode engine-mode company-shell auto-dictionary reveal-in-osx-finder pbcopy osx-trash osx-dictionary launchctl git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter flycheck-pos-tip pos-tip diff-hl noflet sbt-mode scala-mode xterm-color shell-pop multi-term eshell-z eshell-prompt-extras esh-help rvm ruby-tools ruby-test-mode rubocop rspec-mode robe rbenv rake minitest chruby bundler inf-ruby restclient-helm ob-restclient ob-http company-restclient restclient know-your-http-well ranger web-beautify plantuml-mode ox-reveal org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-mime org-download lua-mode livid-mode skewer-mode simple-httpd js2-refactor js2-mode js-doc htmlize gnuplot company-tern tern coffee-mode yapfify pyvenv pytest pyenv-mode py-isort pip-requirements mmm-mode markdown-toc markdown-mode live-py-mode hy-mode dash-functional helm-pydoc gh-md cython-mode company-anaconda anaconda-mode pythonic web-mode tagedit smeargle slim-mode scss-mode sass-mode pug-mode orgit magit-gitflow less-css-mode helm-gitignore helm-css-scss haml-mode go-guru go-eldoc gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link evil-magit magit transient git-commit with-editor erc-yt erc-view-log erc-social-graph erc-image erc-hl-nicks emmet-mode company-web web-completion-data company-go go-mode unfill omnisharp flycheck mwim helm-company helm-c-yasnippet fuzzy dockerfile-mode docker json-mode tablist magit-popup docker-tramp json-snatcher json-reformat deft csv-mode csharp-mode company-statistics company clojure-snippets clj-refactor inflections edn multiple-cursors paredit peg cider-eval-sexp-fu cider sesman seq queue parseedn clojure-mode parseclj a auto-yasnippet yasnippet ac-ispell auto-complete ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint indent-guide hydra lv hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation helm-themes helm-swoop helm-projectile projectile pkg-info epl helm-mode-manager helm-make helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist highlight evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu elisp-slime-nav dumb-jump f dash s diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async))
 '(safe-local-variable-values
   '((magit-todos-exclude-globs "*.html" "*.map.*" "*.js" "*.css")
     (magit-todos-exclude-globs "*.html" "*.map" "*.js" "*.css")
     (cider-shadow-cljs-default-options . "app")
     (javascript-backend . tide)
     (javascript-backend . tern)
     (javascript-backend . lsp)
     (go-backend . go-mode)
     (go-backend . lsp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight-parentheses-highlight ((nil (:weight ultra-bold))) t))
