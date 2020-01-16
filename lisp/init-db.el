(use-package sql-indent
  :ensure t
  :defer t
  :config
  (add-hook 'sql-mode-hook 'sqlind-setup)
  )

(provide 'init-db)
