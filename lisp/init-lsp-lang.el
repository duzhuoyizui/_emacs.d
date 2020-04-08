(use-package spinner
  :pin gnu
  :ensure t)

(use-package lsp-mode
  :pin melpa-stable
  :ensure t
  :defer t
  :hook
  (emacs-lisp-mode . lsp)
  (python-mode . lsp)
  ;; (rjsx-mode . lsp) ; so slow
  (go-mode . lsp-deferred)
  ;; integration which key
  ;; (lsp-mode . lsp-enable-which-key-integration)
  :commands lsp
  :init
  ;; prefer using lsp-ui (flycheck) over flymake.
  (setq
   lsp-prefer-flymake nil
   lsp-enable-folding nil
   lsp-enable-snippet nil
   lsp-print-performance nil
   lsp-log-io nil
   lsp-enable-symbol-highlighting nil
   lsp-enable-completion-at-point nil
   lsp-enable-links nil
   lsp-restart 'auto-restart
   lsp-client-packages '(lsp-clients)
   )
  )

(use-package lsp-ui
  :pin melpa-stable
  :ensure t
  :defer t
  :commands lsp-ui-mode
  :bind (:map lsp-mode-map
			  ("M-." . lsp-ui-peek-find-definitions)
			  ("M-?" . lsp-ui-peek-find-references)
			  ("C-c f" . lsp-format-buffer))
  :init
  (setq lsp-ui-doc-enable nil
        lsp-ui-sideline-show-diagnostics nil
        lsp-ui-sideline-show-symbol nil
        lsp-ui-sideline-show-code-actions nil
        lsp-ui-sideline-show-hover nil)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  )

(use-package company
  :pin melpa-stable
  :ensure t
  :defer 0.5
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
  (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
  :config
  (global-company-mode)
  )

(use-package company-lsp
  :pin melpa-stable
  :ensure t
  :defer 0.5
  :commands company-lsp
  )

(require 'python)
(set-variable 'py-indent-offset 4)
(set-variable 'python-indent-guess-indent-offset nil)

(use-package go-mode
  :pin melpa-stable
  :ensure t
  :defer t
  :init
  (defun lsp-go-install-save-hooks ()
    (add-hook 'before-save-hook #'lsp-format-buffer t t)
    (add-hook 'before-save-hook #'lsp-organize-imports t t))
  (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
  )

(provide 'init-lsp-lang)
