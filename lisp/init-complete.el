(require 'auto-complete)
(global-auto-complete-mode t)

(setq ac-auto-show-menu t)
(setq ac-use-menu-map t)
(setq ac-menu-height 8)
(setq ac-use-quick-help nil)

(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
(global-set-key "\M-/" 'auto-complete)

(add-to-list 'ac-modes 'js2-mode)

(provide 'init-complete)
