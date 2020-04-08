(use-package sql-indent
  :pin gnu
  :ensure t
  :defer t
  :init
  (add-hook 'sql-mode-hook 'sqlind-setup)
  )

(provide 'init-db)
