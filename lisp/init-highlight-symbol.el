(use-package highlight-symbol
  :ensure t
  :config
  (global-set-key (kbd "M--") 'highlight-symbol-at-point)
  (global-set-key (kbd "M-n") 'highlight-symbol-next)
  (global-set-key (kbd "M-p") 'highlight-symbol-prev)
  )

(provide 'init-highlight-symbol)
