(use-package company
  :ensure t
  :defer 5
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

  ;; for go
  (use-package company-go
    :ensure t
    :config
    (add-hook 'go-mode-hook (lambda ()
                            (set (make-local-variable 'company-backends) '(company-go))
                            (company-mode)))
    )
  )

(use-package yasnippet
  :ensure t
  :config
  (use-package  yasnippet-snippets
    :ensure t
    )
  (yas-global-mode 1)
  )

(provide 'init-complete)
