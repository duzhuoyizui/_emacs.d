(use-package which-key
  :ensure t
  :defer 1
  :config
  ;; Allow C-h to trigger which-key before it is done automatically
  (setq which-key-show-early-on-C-h t)
  (setq which-key-idle-delay 10000)
  (setq which-key-idle-secondary-delay 0.05)
  (which-key-setup-side-window-right)
  (which-key-mode)
  )

(provide 'init-which-key)
