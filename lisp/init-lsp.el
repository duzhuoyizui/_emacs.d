(use-package spinner
  :ensure t)

(use-package lsp-mode
  :ensure t
  :hook
  (python-mode . lsp)
  ;; (rjsx-mode . lsp) ;; shit, too slow !!
  (go-mode . lsp)

  :commands lsp
  :config

  (global-set-key (kbd "M-.") 'lsp-goto-type-definition)

  ;; prefer using lsp-ui (flycheck) over flymake.
  (setq lsp-prefer-flymake nil)

  (use-package lsp-ui
    :ensure t
    :bind
    (:map lsp-mode-map
          ("C-c m"   . lsp-ui-imenu)
          ("M-." . lsp-ui-peek-find-definitions)
          ("C-c i"   . lsp-ui-peek-find-implementation)
          )

    :config
    (setq lsp-ui-doc-enable nil
          lsp-ui-sideline-show-diagnostics nil
          lsp-ui-sideline-show-symbol nil
          lsp-ui-sideline-show-code-actions nil
          lsp-ui-sideline-show-hover nil
          )

    ;; You may remap xref-find-{definitions,references} (bound to `M-.` `M-?` by default):
    (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
    (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)

    (add-hook 'lsp-mode-hook 'lsp-ui-mode)
    )

  (use-package company-lsp
    :ensure t
    :commands company-lsp
    )
  )


(provide 'init-lsp)
