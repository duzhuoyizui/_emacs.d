(use-package evil
  :pin melpa
  :ensure t
  :init
  (setq evil-want-C-i-jump nil)
  :config
  ;;(evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle)
  (evil-mode 1)
  )

(use-package evil-leader
  :pin melpa
  :ensure t
  :init
  (setq evil-leader/leader ",")
  (evil-leader/set-key
	"0" 'delete-window
	"1" 'delete-other-windows
	"2" 'split-window-below
	"3" 'split-window-right
	"b" 'switch-to-buffer
	"c f" 'counsel-find-file
	"c g" 'counsel-git
	"c j" 'counsel-git-grep
	"c k" 'counsel-ag
	"c x" 'counsel-M-x
	"c y" 'counsel-yank-pop
	"e" 'find-file
	"k" 'kill-buffer
	"p b" 'counsel-projectile-switch-to-buffer
	"p d" 'counsel-projectile-find-dir
	"p f" 'counsel-projectile-find-file
	"p i" 'projectile-invalidate-cache
	"p p" 'counsel-projectile-switch-project
	"q" 'save-buffers-kill-terminal
	"s ." 'swiper-isearch-thing-at-point
	"s s" 'swiper
	"u t" 'undo-tree-visualize
	"w" 'save-buffer
	"x" 'eshell
	)
  :config
  (global-evil-leader-mode)
  )

(provide 'init-evil)
