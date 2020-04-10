;;----------------------------------------------------------------------------
;; edit 提升编辑效率
;;----------------------------------------------------------------------------

(use-package undo-tree
  :pin gnu
  :ensure t
  :diminish
  :hook (prog-mode . undo-tree-mode)
  )

(use-package multiple-cursors
  :pin melpa
  :ensure t
  :bind (("M-s ;" . mc/mark-all-symbols-like-this-in-defun)
		 ("M-s >" . mc/mark-next-like-this)
		 ("M-s <" . mc/mark-previous-like-this)
		 ("M-s C-a" . mc/mark-all-like-this)
		 )
  )

;; https://github.com/magnars/expand-region.el
(use-package expand-region
  :pin melpa
  :ensure t
  :bind (("M-m" . er/expand-region)
		 ("M-s s" . er/mark-symbol)
		 ("M-s p" . er/mark-outside-pairs)
		 ("M-s P" . er/mark-inside-pairs)
		 ("M-s q" . er/mark-outside-quotes)
		 ("M-s m" . er/mark-comment)
		 ("M-s Q" . er/mark-inside-quotes)
		 ("M-s f" . er/mark-defun))
  )

(use-package highlight-symbol
  :pin melpa
  :ensure t
  :bind (("M--" . highlight-symbol-at-point)
		 ("M-n" . highlight-symbol-next)
		 ("M-p" . highlight-symbol-prev))
  )

(use-package ivy
  :pin melpa
  :ensure t
  :diminish
  :init
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d-%d) ")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode 1)
  )

(use-package swiper
  :pin melpa
  :ensure t
  )

(use-package counsel
  :pin melpa
  :ensure t
  :diminish
  )

(use-package projectile
  :pin melpa
  :ensure t
  :diminish
  :init
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
  (setq projectile-require-project-root nil)
  ;; 对结果进行排序(active buffer + recently opened)
  (setq projectile-sort-order 'recentf-active)
  :config
  (projectile-mode +1)
  (use-package counsel-projectile
    :pin melpa
    :ensure t
	:diminish
    :config
    (counsel-projectile-mode 1)
    )
  )

(use-package avy
  :pin melpa
  :ensure t
  :bind (("M-s i" . avy-goto-word-1)
         ("M-s j" . avy-goto-line)
         ("M-s k" . avy-copy-line))
  :init
  (setq avy-background t)
  )

(use-package git-gutter+
  :pin melpa
  :ensure t
  :bind (("C-x g" . git-gutter+-mode))
  :config (progn
            (define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
            (define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)
            (define-key git-gutter+-mode-map (kbd "C-x r") 'git-gutter+-revert-hunks))
  :diminish (git-gutter+-mode . "gg"))

(use-package ace-window
  :pin melpa
  :ensure t
  :custom
  (set-face-attribute
   'aw-mode-line-face nil
   :inherit 'mode-line-buffer-id
   :foreground "chartreuse")
  :bind (("M-o" . ace-window)
		 ("M-s t" . ace-swap-window))
  :init
  (setq aw-keys '(?1 ?2 ?3 ?4 ?7 ?8 ?9 ?0))
  :config
  (ace-window-display-mode)
  )

(use-package which-key
  :pin melpa-stable
  :ensure t
  :defer 0.5
  :init
  (which-key-setup-minibuffer)
  :config
  (which-key-mode)
  )

(use-package keyfreq
  :pin melpa-stable
  :ensure t
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1)
  )

(provide 'init-edit)
