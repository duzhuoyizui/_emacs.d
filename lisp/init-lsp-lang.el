(use-package spinner
  :pin gnu
  :ensure t
  :defer t
  )

(use-package lsp-mode
  :pin melpa
  :ensure t
  :hook
  (emacs-lisp-mode . lsp)
  (python-mode . lsp)
  ;; (rjsx-mode . lsp) ; so slow
  (go-mode . lsp-deferred)
  :commands lsp
  :bind (("<f9> s r" . lsp-workspace-restart)
		 ("<f9> f r" . lsp-find-references)
		 ("<f9> f d" . lsp-describe-thing-at-point)
		 :map lsp-signature-mode
		 ("<f9> s p" . lsp-signature-previous)
		 ("<f9> s n" . lsp-signature-next)
		 )
  :init
  (setq
   lsp-enable-completion-at-point t
   lsp-enable-folding nil
   lsp-enable-links nil
   lsp-enable-snippet nil
   lsp-enable-symbol-highlighting nil
   lsp-log-io nil
   lsp-prefer-flymake nil   ;; prefer using lsp-ui (flycheck) over flymake.
   lsp-print-performance nil
   lsp-restart 'auto-restart
   )
  :config
  (push "[/\\\\]googleapis$" lsp-file-watch-ignored)
  )

(use-package lsp-ui
  :pin melpa
  :ensure t
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :bind (:map lsp-mode-map
			  ("M-." . lsp-ui-peek-find-definitions)
			  ("M-?" . lsp-ui-peek-find-references)
			  ("C-c f" . lsp-format-buffer))
  :init
  (setq
   lsp-ui-doc-enable nil
   lsp-ui-sideline-show-diagnostics nil
   lsp-ui-sideline-show-symbol nil
   lsp-ui-sideline-show-code-actions nil
   lsp-ui-sideline-show-hover nil
   )
  )

(use-package company
  :pin melpa
  :ensure t
  :hook ((prog-mode . company-mode)
		 (protobuf-mode . company-mode))
  :bind (:map company-active-map
			  ("M-n" . nil)
			  ("M-p" . nil)
			  ("C-n" . company-select-next)
			  ("C-p" . company-select-previous)
			  )
  :init
  ;; markdown-mode, eshell-mode ignore complete
  (setq company-global-modes '(not markdown-mode gfm-mode eshell-mode))
  (setq company-transformers '(company-sort-by-occurrence))
  (setq company-echo-delay 0)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
  )

(use-package company-lsp
  :pin melpa
  :ensure t
  :commands company-lsp
  )

(use-package python
  :pin melpa
  :ensure t
  :mode "\\.py'"
  :interpreter "python"
  :init
  (set-variable 'py-indent-offset 4)
  (set-variable 'python-indent-guess-indent-offset nil)
 )

(use-package go-mode
  :after lsp-mode
  :pin melpa
  :ensure t
  :mode "\\.go\\'"
  :interpreter "go"
  :init
  (defun lsp-go-install-save-hooks ()
    (add-hook 'before-save-hook #'lsp-format-buffer t t)
    (add-hook 'before-save-hook #'lsp-organize-imports t t))
  (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
  )

(use-package protobuf-mode
  :pin melpa
  :ensure t
  :mode "\\.proto\\'"
  :init
  (defconst my-protobuf-style
    '((c-basic-offset . 2)
      (indent-tabs-mode . nil)))
  (add-hook 'protobuf-mode-hook
			(lambda () (c-add-style "my-style" my-protobuf-style t)))
  )

(use-package lua-mode
  :pin melpa
  :ensure t
  :mode "\\.lua\\'"
  )

(provide 'init-lsp-lang)
