(use-package spinner
  :ensure t)

(use-package lsp-mode
  :ensure t
  :hook
  (python-mode . lsp)
  ;; (rjsx-mode . lsp) ;; shit, too slow !!
  :commands lsp
  :config

  (global-set-key (kbd "M-.") 'lsp-goto-type-definition)

  ;; prefer using lsp-ui (flycheck) over flymake.
  (setq lsp-prefer-flymake nil)

  (use-package lsp-ui
    :ensure t
    :config
    (setq lsp-ui-doc-enable nil
          lsp-ui-sideline-show-diagnostics nil
          lsp-ui-sideline-show-symbol nil
          lsp-ui-sideline-show-code-actions nil
          lsp-ui-sideline-show-hover nil
          )
    (add-hook 'lsp-mode-hook 'lsp-ui-mode)
    )

  (use-package company-lsp
    :ensure t
    :commands company-lsp
    )
  )


(provide 'init-lsp)
