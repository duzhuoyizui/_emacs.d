;;----------------------------------------------------------------------------
;; edit 提升编辑效率
;;----------------------------------------------------------------------------

(use-package undo-tree
  :pin gnu
  :ensure t
  :bind ("C-x u" . undo-tree-visualize)
  )

(use-package multiple-cursors
  :pin melpa
  :ensure t
  :bind (("M-s ;" . mc/mark-all-symbols-like-this-in-defun))
  )

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
  :bind (("C-x b" . ivy-switch-buffer)
		 ("<f6>" . ivy-resume))
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
  :bind (("C-s" . swiper)))

(use-package counsel
  :pin melpa
  :ensure t
  :bind (("M-s [" . counsel-rg)
		 ("M-s ]" . counsel-git)
		 ("M-x" . counsel-M-x)
		 ("<f9> x" . counsel-M-x)
		 ("M-y" . counsel-yank-pop)
		 ("<f9> f" . counsel-find-file)
		 ("C-x C-f" . counsel-find-file)
		 )
  :config
  (setq counsel-rg-base-command "rg -i --max-columns 240 --no-heading --with-filename --line-number %s")
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
  :bind (("<f9> g g" . git-gutter+-mode))
  :config (progn
            (define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
            (define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)
            (define-key git-gutter+-mode-map (kbd "C-x r") 'git-gutter+-revert-hunks))
  :diminish (git-gutter+-mode . "gg"))

(use-package ace-window
  :pin melpa
  :ensure t
  :bind (("M-o" . ace-window)
		 ("M-s t" . ace-swap-window))
  :config
  (setq aw-keys '(?1 ?2 ?3 ?4 ?7 ?8 ?9 ?0))
  (set-face-attribute
   'aw-mode-line-face nil
   :inherit 'mode-line-buffer-id
   :foreground "chartreuse")
  )

(use-package which-key
  :pin melpa
  :ensure t
  :hook (prog-mode-hook . which-key-mode)
  :init
  (which-key-setup-minibuffer)
  )

(use-package keyfreq
  :pin melpa
  :ensure t
  :init
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1)
  )

(use-package linum-relative
  :pin melpa
  :ensure t
  :bind (("M-s r" . linum-relative-toggle))
  :init
  (setq linum-relative-backend 'display-line-numbers-mode)
  )

(provide 'init-edit)
