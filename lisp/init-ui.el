;;----------------------------------------------------------------------------
;; UI
;;----------------------------------------------------------------------------
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)
(setq indicate-empty-lines t)
(setq show-trailing-whitespace t)
(show-paren-mode t)
(tool-bar-mode nil)
(set-scroll-bar-mode nil)
(menu-bar-mode -1)
(column-number-mode t)

;; disable bold
(defadvice set-face-attribute
    (before no-bold (face frame &rest args) activate)
  (setq args
        (mapcar (lambda(x) (if (eq x 'bold) 'normal x))
                args)))

(use-package doom-modeline
  :pin melpa
  :ensure t
  :init
  (setq doom-modeline-project-detection 'ffip)
  (setq doom-modeline-buffer-modification-icon nil)
  :config
  (set-face-foreground 'doom-modeline-buffer-modified "sandybrown")
  (doom-modeline-mode 1)
  )

(use-package rainbow-delimiters
  :pin melpa
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode)
  )

(load-theme 'leuven)

(provide 'init-ui)
