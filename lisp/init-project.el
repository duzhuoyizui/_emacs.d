(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d-%d) ")
  (setq enable-recursive-minibuffers t)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  )

(use-package swiper
  :ensure t
  :defer t
  :config
  (global-set-key "\C-s" 'swiper))

(use-package counsel
  :ensure t
  :config
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "M-y") 'counsel-yank-pop)
  )

(use-package projectile
  :ensure t
  :config
  (setq projectile-enable-caching t)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1)
  )

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-mode 1)
  )

(use-package magit
  :ensure t
  :defer t
  :bind (("C-x g" . magit-status)))

(use-package avy
  :ensure t
  :defer t
  :bind (("<f9>" . avy-goto-char-2)
         ("M-s j" . avy-goto-line))
  :config
  (setq avy-background t))

(provide 'init-project)
