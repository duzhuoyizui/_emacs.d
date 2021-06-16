(use-package dired-subtree
  :pin melpa
  :ensure t
  :init
  (setq dired-subtree-use-backgrounds nil)
  :config
  (bind-keys :map dired-mode-map
             ("i" . dired-subtree-insert)
             (";" . dired-subtree-remove))
  )

(provide 'init-dired)
