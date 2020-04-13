(use-package yaml-mode
  :pin melpa
  :ensure t
  :mode "\\.yml'"
  :init
  (add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
  )

(provide 'init-yaml)
