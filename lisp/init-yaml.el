(use-package yaml-mode
  :ensure t
  :defer 5
  :init
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  :config
  (add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
  )

(provide 'init-yaml)
