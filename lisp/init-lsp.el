(use-package spinner
  :ensure t)

(use-package lsp-mode
  :ensure t
  :hook
  (python-mode . lsp)
  :commands lsp
  :config

  ;; prefer using lsp-ui (flycheck) over flymake.
  (setq lsp-prefer-flymake nil)

  (use-package lsp-ui
    :ensure t
    :config
    (setq lsp-ui-doc-enable nil
          lsp-ui-sideline-show-diagnostics nil)
    (add-hook 'lsp-mode-hook 'lsp-ui-mode)
    )

  (use-package company-lsp
    :ensure t
    :commands company-lsp
    )
  )


(provide 'init-lsp)
