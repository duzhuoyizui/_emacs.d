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
		 ("M-i" . lsp-smart-buffer)
		 :map lsp-signature-mode
		 ("<f9> s p" . lsp-signature-previous)
		 ("<f9> s n" . lsp-signature-next)
		 )
  :init
  (setq
   lsp-completion-enable t
   lsp-completion-enable-additional-text-edit nil
   lsp-enable-folding nil
   lsp-enable-links nil
   lsp-enable-snippet nil
   lsp-enable-symbol-highlighting nil
   lsp-semantic-highlighting t
   lsp-log-io nil
   lsp-diagnostics-provider :flycheck
   lsp-print-performance nil
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

(use-package company
  :pin melpa
  :ensure t
  :hook ((prog-mode-hook . company-mode)
		 (protobuf-mode-hook . company-mode))
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

(use-package go-mode
  :pin melpa
  :ensure t
  :mode "\\.go\\'"
  :interpreter "go"
  :config
  (use-package go-tag
	:pin melpa
	:ensure t
	:init
	(setq go-tag-args (list "-transform" "snakecase"))
	(with-eval-after-load 'go-mode
	  (define-key go-mode-map (kbd "C-c t") #'go-tag-add)
	  (define-key go-mode-map (kbd "C-c T") #'go-tag-remove))
	)
  (use-package gotest
	:pin melpa
	:ensure t
	:init
	(setq go-test-verbose t)
	:config
	(define-key go-mode-map (kbd "<f9> t f") 'go-test-current-file)
	(define-key go-mode-map (kbd "<f9> t t") 'go-test-current-test)
	(define-key go-mode-map (kbd "<f9> t p") 'go-test-current-project)
	)
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
