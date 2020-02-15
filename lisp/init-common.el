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

;; (global-set-key [(f3)] 'eshell)
(global-set-key [(f4)] 'insert-current-date-time)
(global-set-key [(f6)] 'show-file-name)

(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "M-s >") 'mc/mark-next-like-this)
  (global-set-key (kbd "M-s <") 'mc/mark-previous-like-this)
  (global-set-key (kbd "M-s C-a") 'mc/mark-all-like-this)
  (global-set-key (kbd "M-s a") 'mc/edit-beginnings-of-lines)
  (global-set-key (kbd "M-s e") 'mc/edit-ends-of-lines)
  )

;; https://github.com/magnars/expand-region.el
(use-package expand-region
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
  :ensure t
  :config
  (global-set-key (kbd "M--") 'highlight-symbol-at-point)
  (global-set-key (kbd "M-n") 'highlight-symbol-next)
  (global-set-key (kbd "M-p") 'highlight-symbol-prev)
  )

(use-package ivy
  :ensure t
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d-%d) ")
  (setq enable-recursive-minibuffers t)
  (global-set-key (kbd "<f7>") 'ivy-resume)
  (ivy-mode 1)
  )

(use-package swiper
  :ensure t
  :config
  (global-set-key (kbd "C-s") 'swiper)
  )

(use-package counsel
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
  :ensure t
  :config
  (setq projectile-enable-caching t)
  (setq projectile-indexing-method 'native) ; 默认是 alien 但是会使 .projectile 文件变无效（不知道是不是 bug）
  (setq projectile-require-project-root nil) ; 强制需要 .projectile 文件
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "<f3>") 'projectile-run-eshell)
  (projectile-mode +1)
  :init
  (use-package counsel-projectile
    :ensure t
    :config
    (counsel-projectile-mode 1)
    )
  )

(use-package avy
  :ensure t
  :bind (("M-s i" . avy-goto-word-1)
         ("M-s j" . avy-goto-line)
         ("M-s k" . avy-copy-line))
  :config
  (setq avy-background t)
  )

(use-package git-gutter+
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
  :ensure t
  :config
  (global-set-key (kbd "M-o") 'ace-window)
  (global-set-key (kbd "M-s t") 'ace-swap-window)
  (ace-window-display-mode)
  )

(use-package which-key
  :ensure t
  :defer t
  :config
  (which-key-setup-minibuffer)
  (which-key-mode)
  )

(use-package company
  :ensure t
  :init (global-company-mode)
  :config
  ;; markdown-mode, eshell-mode ignore complete
  (setq company-global-modes '(not markdown-mode gfm-mode eshell-mode))
  (setq company-transformers '(company-sort-by-occurrence))
  (setq company-echo-delay 0)
  (setq company-idle-delay 0)
  (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing


  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)

  (use-package company-lsp
    :ensure t
    :commands company-lsp
    )
  )

(provide 'init-common)
