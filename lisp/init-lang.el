(use-package projectile
  :pin melpa
  :ensure t
  :bind-keymap (("<f8>" . projectile-command-map))
  :bind (:map projectile-command-map
			  ("F" . projectile-find-file-other-window)
			  ("w" . projectile-find-file-in-known-projects)
			  ("D" . projectile-dired-other-window)
			  ("k" . projectile-kill-buffers)
			  ("v" . projectile-vc)
			  ("b" . projectile-switch-to-buffer)
			  )
  :config
  ;; 打开项目缓存, 否则大的项目每次构建会比较慢
  ;; 你可以通过下面两个名称来清除缓存
  ;; - projectile-purge-file-from-cache
  ;; - projectile-purge-dir-from-cache
  (setq projectile-enable-caching t)
  ;; projectile 有三种构建索引的方式: native, hybird, alien
  ;;   native 使用 Emacs lisp 实现, hybird/alien 使用外部命令类似 find, git 来实现
  ;;   alien 优化了 hybird 的性能: 它不会对外部命令返回的结果做任何处理和排序, 以获得最好的性能
  ;;   使用外部命令的话, 类似 .gitignore 会自动生效
  ;; 注意: alien 会忽略 .projectile 文件
  (setq projectile-indexing-method 'alien)
  ;; 在每个目录下都可用(即使没有项目文件)
  (setq projectile-require-project-root 'prompt)
  ;; 对结果进行排序(active buffer + recently opened)
  (setq projectile-sort-order 'recentf-active)
  ;; use ivy as completion system
  (setq projectile-completion-system 'ivy)

  (defun project-find-go-module (dir)
	(when-let ((root (locate-dominating-file dir "go.mod")))
      (cons 'go-module root)))

  (cl-defmethod project-root ((project (head go-module)))
	(cdr project))

  (add-hook 'project-find-functions #'project-find-go-module)

  (use-package counsel-projectile
    :pin melpa
    :ensure t
    :config
    (counsel-projectile-mode 1)
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

(use-package flycheck-golangci-lint
  :pin melpa
  :ensure t
  :hook (go-mode . flycheck-golangci-lint-setup)
  :init
  (defvar-local flycheck-local-checkers nil)
  (defun +flycheck-checker-get(fn checker property)
    (or (alist-get property (alist-get checker flycheck-local-checkers))
        (funcall fn checker property)))
  (advice-add 'flycheck-checker-get :around '+flycheck-checker-get)
  (add-hook 'go-mode-hook (lambda()
                            (flycheck-golangci-lint-setup)
                            (setq flycheck-local-checkers '((lsp . ((next-checkers . (golangci-lint))))))))
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
	(save-buffer)
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


(provide 'init-lang)
