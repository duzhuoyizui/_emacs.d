(use-package sql-indent
  :pin melpa
  :ensure t
  :defer t
  :config
  (add-hook 'sql-mode-hook 'sqlind-setup)
  )

(provide 'init-db)
