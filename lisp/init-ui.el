;;----------------------------------------------------------------------------
;; UI setting
;;----------------------------------------------------------------------------
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)
(setq indicate-empty-lines t)
(setq show-trailing-whitespace t)
(show-paren-mode t)
(tool-bar-mode -1)
(set-scroll-bar-mode nil)
(menu-bar-mode -1)
(column-number-mode t)
(blink-cursor-mode -1)
(setq visible-cursor nil)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Set default font
(cond
 ((string-equal system-type "gnu/linux")
  (set-face-attribute 'default nil
                      :family "Sarasa Mono SC"
                      :height 135
                      :weight 'normal
                      :width 'normal))
 ((string-equal system-type "darwin")
  (set-face-attribute 'default nil
                      :family "SF Mono"
                      :height 160
                      :weight 'normal
                      :width 'normal))
 ((string-equal system-type "windows-nt")
  (set-face-attribute 'default nil
                      :family "Microsoft Yahei Mono"
                      :height 135
                      :weight 'normal
                      :width 'normal))
 )

;; disable bold
(defadvice set-face-attribute
    (before no-bold (face frame &rest args) activate)
  (setq args
        (mapcar (lambda(x) (if (eq x 'bold) 'normal x))
                args)))

(use-package doom-modeline
  :pin melpa
  :ensure t
  :config
  (set-face-foreground 'doom-modeline-buffer-modified "burlywood3")
  (set-face-foreground 'doom-modeline-project-dir "burlywood3") ;; project name
  (setq doom-modeline-buffer-modification-icon nil)
  (setq doom-modeline-project-detection 'projectile)
  (setq doom-modeline-buffer-file-name-style 'truncate-upto-project)
  (setq doom-modeline-lsp t)
  (setq doom-modeline-modal-icon t)
  (setq doom-modeline-env-version t)
  (setq doom-modeline-window-width-limit fill-column)
  (setq doom-modeline-minor-modes nil)
  (setq doom-modeline-indent-info t)
  (doom-modeline-mode 1)
  )

(use-package rainbow-delimiters
  :pin melpa
  :ensure t
  :hook (prog-mode-hook . rainbow-delimiters-mode)
  )

;; (load-theme 'leuven)

(use-package kaolin-themes
  :pin melpa
  :ensure t
  :config

  (setq kaolin-themes-bold t
		kaolin-themes-italic t
		kaolin-themes-underline t)
  (setq kaolin-themes-modeline-border nil)
  (setq kaolin-themes-hl-line-colored t)
  (setq kaolin-themes-distinct-fringe t)
  (setq kaolin-themes-git-gutter-solid t)
  (setq kaolin-themes-org-scale-headings nil)

  ;; (setq kaolin-valley-light-alt-bg t)
  ;; (load-theme 'kaolin-valley-light t)

  (setq kaolin-light-alt-bg t)
  (load-theme 'kaolin-light t)
  )

;; (set-face-foreground 'line-number "darkgrey")

(use-package display-fill-column-indicator
  :pin manual
  :custom
  (display-fill-column-indicator-column 100)
  (display-fill-column-indicator-character ?\u2502)
  ;; :init
  ;; (global-display-fill-column-indicator-mode t)
  )

(provide 'init-ui)
