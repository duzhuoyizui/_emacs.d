;;----------------------------------------------------------------------------
;; Common: 提升编辑效率
;;----------------------------------------------------------------------------
(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t)

(setq auto-save-default nil)
(setq mouse-yank-at-point t)
(setq make-backup-files nil)
(setq create-lockfiles nil)
(setq-default tab-width 4)

(electric-pair-mode 1)
(electric-indent-mode 1)
;;(electric-quote-mode 1)

(defvar current-date-time-format "%Y-%m-%d %H:%M:%S %a"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defun insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
  (interactive)
  (insert (format-time-string current-date-time-format (current-time)))
  )

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(global-set-key [(f3)] 'eshell)
(global-set-key [(f4)] 'insert-current-date-time)
(global-set-key [(f6)] 'show-file-name)

(use-package multiple-cursors
  :pin melpa
  :ensure t
  :config
  (global-set-key (kbd "M-s ;") 'mc/mark-all-symbols-like-this-in-defun)
  (global-set-key (kbd "M-s >") 'mc/mark-next-like-this)
  (global-set-key (kbd "M-s <") 'mc/mark-previous-like-this)
  (global-set-key (kbd "M-s C-a") 'mc/mark-all-like-this)
  )

;; https://github.com/magnars/expand-region.el
(use-package expand-region
  :pin melpa
  :ensure t
  :config
  (global-set-key (kbd "M-m") 'er/expand-region)
  (global-set-key (kbd "M-s s") 'er/mark-symbol)
  (global-set-key (kbd "M-s p") 'er/mark-outside-pairs)
  (global-set-key (kbd "M-s P") 'er/mark-inside-pairs)
  (global-set-key (kbd "M-s q") 'er/mark-outside-quotes)
  (global-set-key (kbd "M-s Q") 'er/mark-inside-quotes)
  (global-set-key (kbd "M-s m") 'er/mark-comment)
  (global-set-key (kbd "M-s f") 'er/mark-defun)
  )

(use-package highlight-symbol
  :pin melpa
  :ensure t
  :config
  (global-set-key (kbd "M--") 'highlight-symbol-at-point)
  (global-set-key (kbd "M-n") 'highlight-symbol-next)
  (global-set-key (kbd "M-p") 'highlight-symbol-prev)
  )

(use-package ivy
  :pin melpa
  :ensure t
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d-%d) ")
  (setq enable-recursive-minibuffers t)
  (global-set-key (kbd "<f7>") 'ivy-resume)
  (ivy-mode 1)
  )

(use-package swiper
  :pin melpa
  :ensure t
  :config
  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "M-s .") 'swiper-isearch-thing-at-point)
  )

(use-package counsel
  :pin melpa
  :ensure t
  :config
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "M-y") 'counsel-yank-pop)
  (global-set-key (kbd "<f12>") 'counsel-semantic-or-imenu)
  )

(use-package projectile
  :pin melpa
  :ensure t
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
  (setq projectile-require-project-root nil)
  ;; 对结果进行排序(active buffer + recently opened)
  (setq projectile-sort-order 'recentf-active)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1)
  :init
  (use-package counsel-projectile
    :pin melpa
    :ensure t
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
  :config
  (setq avy-background t)
  )

(use-package git-gutter+
  :pin melpa
  :ensure t
  :defer t
  :init
  (global-set-key (kbd "C-x g") 'git-gutter+-mode)
  :config (progn
            (define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
            (define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)
            (define-key git-gutter+-mode-map (kbd "C-x r") 'git-gutter+-revert-hunks))
  :diminish (git-gutter+-mode . "gg"))

(use-package ace-window
  :pin melpa
  :ensure t
  :config
  (set-face-attribute
     'aw-mode-line-face nil
     :inherit 'mode-line-buffer-id
     :foreground "chartreuse")
  (setq aw-keys '(?1 ?2 ?3 ?4 ?7 ?8 ?9 ?0))
  (global-set-key (kbd "M-o") 'ace-window)
  (global-set-key (kbd "M-s t") 'ace-swap-window)
  (ace-window-display-mode)
  )

(provide 'init-common)
