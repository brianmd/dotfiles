(provide 'my-mouse)

  ;; (unless false
  ;; ;(unless window-system
  ;;   ;; (require 'mwheel)
  ;;   ;; (require 'mouse)
  ;;   ;; (xterm-mouse-mode t)
  ;;   ;; (mouse-wheel-mode t)
  ;;   ;; (global-set-key [mouse-4] 'next-line)
  ;;   ;; (global-set-key [mouse-5] 'previous-line)
  ;;   ;; (global-set-key [mouse-4] 'scroll-down-line)
  ;;   ;; (global-set-key [mouse-5] 'scroll-up-line)
  ;;   )

  ;; (setq scroll-conservatively 101) ;; move minimum when cursor exits view, instead of recentering
  ;; (setq mouse-wheel-scroll-amount '(1)) ;; mouse scroll moves 1 line at a time, instead of 5 lines
  ;; (setq mouse-wheel-progressive-speed nil) ;; on a long mouse scroll keep scrolling by 1 line

  ;; (setq mouse-wheel-scroll-amount '(2 ((shift) . 1))) ;; two lines at a time
  ;; (setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
  ;; (setq mouse-wheel-follow-mouse't) ;; scroll window under mouse

  ;; ( require 'smooth-scroll                        ) ;; Smooth scroll
  ;; ( smooth-scroll-mode 1                          ) ;; Enable it
  ;; ( setq smooth-scroll/vscroll-step-size 5        ) ;; Set the speed right

(xterm-mouse-mode -1)
;; (setq x-select-enable-clipboard t)
(setq mouse-drag-copy-region t)

