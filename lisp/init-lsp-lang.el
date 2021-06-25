(use-package spinner
  :pin gnu
  :ensure t
  :defer t
  )

(use-package lsp-mode
  :pin melpa
  :ensure t
  :hook
  ;; (emacs-lisp-mode-hook . lsp-deferred)
  (python-mode-hook . lsp-deferred)
  ;; (rjsx-mode . lsp) ; so slow
  (go-mode-hook . lsp-deferred)
  :commands lsp
  :bind (("<f9> s s" . lsp-workspace-restart)
		 ("<f9> s r" . lsp-find-references)
		 ("<f9> s d" . lsp-describe-thing-at-point)
		 ("<f9> s i" . lsp-find-implementation)
		 ("M-i" . lsp-smart-buffer)o
		 :map lsp-signature-mode
		 ("<f9> s p" . lsp-signature-previous)
		 ("<f9> s n" . lsp-signature-next)
		 )
  :init
  (setq
   lsp-completion-enable t
   lsp-completion-enable-additional-text-edit nil
   lsp-enable-folding t
   lsp-enable-links t
   lsp-enable-snippet nil
   lsp-log-io nil
   lsp-enable-symbol-highlighting nil
   lsp-diagnostics-provider :flycheck
   lsp-restart 'auto-restart
   lsp-eldoc-render-all nil
   lsp-signature-render-documentation nil
   lsp-headerline-breadcrumb-enable nil

   lsp-pyls-server-command 'pyright
   )
  (defun lsp-smart-buffer ()
	"call lsp tool chains, smart make buffer"
	(interactive)
	(flycheck-buffer)
	(lsp-format-buffer)
	(lsp-organize-imports)
	)
  :config
  (push "[/\\\\]googleapis$" lsp-file-watch-ignored)
  )

(use-package lsp-ui
  :pin melpa
  :ensure t
  :commands lsp-ui-mode
  :hook (lsp-mode-hook . lsp-ui-mode)
  :bind (("<f9> s c" . lsp-ui-flycheck-list)
		 :map lsp-mode-map
		 ("M-." . lsp-ui-peek-find-definitions)
		 ("M-?" . lsp-ui-peek-find-references))
  :init
  (setq
   lsp-ui-doc-enable nil
   lsp-ui-sideline-show-diagnostics nil
   lsp-ui-sideline-show-symbol nil
   lsp-ui-sideline-show-code-actions nil
   lsp-ui-sideline-show-hover nil
   )
  )

(use-package python
  :pin melpa
  :ensure t
  :mode "\\.py'"
  :interpreter "python"
  :init
  (set-variable 'py-indent-offset 4)
  (set-variable 'python-indent-guess-indent-offset nil)
  :config
  (use-package lsp-pyright
	:pin melpa
	:ensure t
	:hook (python-mode . (lambda ()
                           (require 'lsp-pyright)
                           (lsp))))  ; or lsp-deferred
  )


(provide 'init-lsp-lang)
