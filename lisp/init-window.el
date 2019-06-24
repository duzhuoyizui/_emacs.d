(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "M-o") 'ace-window)
  (ace-window-display-mode)
  )

(provide 'init-window)
