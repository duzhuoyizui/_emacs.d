(use-package gnu-elpa-keyring-update
  :ensure t)

(use-package spinner
  :ensure t)

(use-package lsp-mode
  :ensure t
  :hook
  (emacs-lisp-mode . lsp)
  (python-mode . lsp)
  ;; (rjsx-mode . lsp) ; so slow
  (go-mode . lsp-deferred)
  :commands lsp
  :config

  ;; prefer using lsp-ui (flycheck) over flymake.
  (setq
   lsp-prefer-flymake nil
   lsp-enable-snippet nil
   lsp-print-performance nil
   ;;lsp-log-io nil
   )
  )

(use-package go-mode
  :ensure t
  :defer t
  :config
  (defun lsp-go-install-save-hooks ()
    (add-hook 'before-save-hook #'lsp-format-buffer t t)
    (add-hook 'before-save-hook #'lsp-organize-imports t t))
  (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
  )

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :bind
  (:map lsp-mode-map
        ("M-." . lsp-ui-peek-find-definitions)
        ("M-?" . lsp-ui-peek-find-references)
        ("C-c f" . lsp-format-buffer)
        )
  :config
  (setq lsp-ui-doc-enable nil
        lsp-ui-sideline-show-diagnostics nil
        lsp-ui-sideline-show-symbol nil
        lsp-ui-sideline-show-code-actions nil
        lsp-ui-sideline-show-hover nil)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  )

(use-package company
  :ensure t
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
  )

(use-package company-lsp
  :ensure t
  :commands company-lsp
  )

(provide 'init-lsp)
