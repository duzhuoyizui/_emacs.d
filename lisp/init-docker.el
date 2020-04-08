(use-package dockerfile-mode
  :pin melpa
  :ensure t
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
  )

(provide 'init-docker)
