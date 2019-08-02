(use-package dockerfile-mode
  :ensure t
  :defer 5
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
  )

(provide 'init-docker)
