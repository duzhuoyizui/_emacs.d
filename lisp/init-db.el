(use-package sql-indent
  :pin gnu
  :ensure t
  :hook (sql-mode . sqlind-minor-mode)
  )

(provide 'init-db)
