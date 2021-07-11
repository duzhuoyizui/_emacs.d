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

(setq display-time-default-load-average nil
	  display-time-format "[%m-%d %H:%M]")
(display-time-mode t)

;; Set default font
(cond
 ((string-equal system-type "gnu/linux")
  (set-face-attribute 'default nil
                      :family "Hack"
                      :height 110
                      :weight 'normal
                      :width 'normal))
 ((string-equal system-type "darwin")
  (set-face-attribute 'default nil
                      :family "Hack"
                      :height 150
                      :weight 'normal
                      :width 'normal))
 ((string-equal system-type "windows-nt")
  (set-face-attribute 'default nil
                      :family "Microsoft Yahei Mono"
                      :height 135
                      :weight 'normal
                      :width 'normal))
 )

;; document(org/markdown) use different font
(defun doc-buffer-face-mode-variable ()
  (setq buffer-face-mode-face '(:family "Sarasa Mono SC" :height 155))
  (buffer-face-mode))
(add-hook 'org-mode-hook 'doc-buffer-face-mode-variable)
(add-hook 'markdown-mode-hook 'doc-buffer-face-mode-variable)

(use-package modus-themes
  :pin melpa
  :ensure t
  :init
  (modus-themes-load-themes)
  :config
  (setq modus-themes-slanted-constructs nil
        modus-themes-bold-constructs nil
        modus-themes-no-mixed-fonts t
        modus-themes-subtle-line-numbers nil
        modus-themes-success-deuteranopia t
        modus-themes-inhibit-reload nil

        modus-themes-fringes 'subtle
        modus-themes-lang-checkers 'straight-underline
        modus-themes-syntax nil
        modus-themes-hl-line 'intense-background
        modus-themes-paren-match 'subtle-bold
        modus-themes-links 'neutral-underline-only
        modus-themes-prompts nil
        modus-themes-completions nil ; {nil,'moderate,'opinionated}
        modus-themes-region 'bg-only-no-extend
        modus-themes-diffs 'fg-only-deuteranopia
        modus-themes-org-blocks 'gray-background ; {nil,'gray-background,'tinted-background}

        modus-themes-headings ; this is an alist: read the manual or its doc string
        '((1 . line)
          (2 . rainbow-line-no-bold)
          (t . no-bold))

        modus-themes-variable-pitch-ui nil
        modus-themes-variable-pitch-headings nil
        modus-themes-scale-headings t
        modus-themes-scale-1 1.1
        modus-themes-scale-2 1.15
        modus-themes-scale-3 1.21
        modus-themes-scale-4 1.27
        modus-themes-scale-title 1.33)
  (modus-themes-load-operandi)
  )

(use-package doom-modeline
  :pin melpa
  :ensure t
  :config
  ;; (set-face-foreground 'doom-modeline-buffer-modified "systemOrangeColor")
  ;; (set-face-foreground 'doom-modeline-buffer-major-mode "systemBrownColor")
  ;; (set-face-foreground 'doom-modeline-buffer-minor-mode "systemBrownColor")
  ;; (set-face-foreground 'doom-modeline-project-dir "systemBrownColor")
  ;; (set-face-foreground 'doom-modeline-project-root-dir "systemBrownColor")
  ;; (set-face-foreground 'doom-modeline-project-parent-dir "systemBrownColor")
  ;; (set-face-foreground 'doom-modeline-project-dir "systemBrownColor") ;; project name
  ;; (set-face-foreground 'doom-modeline-buffer-file "systemBrownColor")

  (setq doom-modeline-buffer-modification-icon nil)
  (setq doom-modeline-project-detection 'projectile)
  (setq doom-modeline-buffer-file-name-style 'truncate-upto-project)
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

(set-face-foreground 'line-number "darkgrey")

(use-package display-fill-column-indicator
  :pin manual
  :custom
  (display-fill-column-indicator-column 100)
  (display-fill-column-indicator-character ?\u2502)
  ;; :init
  ;; (global-display-fill-column-indicator-mode t)
  )

;; (use-package beacon
;;   :pin melpa
;;   :ensure t
;;   :init
;;   (setq beacon-color "sandybrown")
;;   :config
;;   (beacon-mode 1)
;;   )

(use-package dashboard
  :pin melpa
  :ensure t
  :init
  (setq dashboard-banner-logo-title "为天地立心，为生民立命，为往圣继绝学，为万世开太平"
		dashboard-center-content t
		dashboard-show-shortcuts nil
		dashboard-items '((projects . 10)
						  (recents  . 10))
		dashboard-startup-banner 'logo
		dashboard-footer-messages '("https://github.com/zhangjie2012/_emacs.d")
		dashboard-projects-switch-function 'counsel-projectile-switch-project-by-name)
  (dashboard-setup-startup-hook)
  )

(provide 'init-ui)
