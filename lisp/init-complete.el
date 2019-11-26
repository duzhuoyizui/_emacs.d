(use-package company
  :ensure t
  :defer 0.2
  :init (global-company-mode)
  :config
  ;; markdown-mode, eshell-mode ignore complete
  (setq company-global-modes '(not markdown-mode gfm-mode eshell-mode))
  (setq company-transformers '(company-sort-by-occurrence))
  (setq company-echo-delay 0)
  (setq company-idle-delay 0)
  (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)

  (use-package company-lsp
    :ensure t
    :commands company-lsp
    )
  )

(provide 'init-complete)
