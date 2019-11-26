(use-package spinner
  :ensure t)

(use-package lsp-mode
  :ensure t
  :hook
  (emacs-lisp-mode . lsp)
  (python-mode . lsp)
  ;; (rjsx-mode . lsp) ; so slow
  (go-mode . lsp)

  :commands lsp
  :config
  ;; prefer using lsp-ui (flycheck) over flymake.
  (setq
   lsp-prefer-flymake nil
   lsp-enable-snippet nil
   lsp-print-performance nil
   lsp-log-io nil
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
  )

(provide 'init-lsp)
