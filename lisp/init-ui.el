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

;; (load-theme 'leuven)

;; (use-package zenburn-theme
;;   :pin melpa
;;   :ensure t
;;   :config
;;   ;; scale headings in org-mode
;;   (setq zenburn-scale-org-headlines t)
;;   ;; scale headings in outline-mode
;;   (setq zenburn-scale-outline-headlines t)
;;   (load-theme 'zenburn t)
;;   )

(use-package modus-themes
  :pin melpa
  :ensure t
  :init
  (modus-themes-load-themes)
  :config
  (setq modus-themes-variable-pitch-ui nil
		modus-themes-variable-pitch-headings nil
		modus-themes-scale-headings t
		modus-themes-scale-1 1.1
		modus-themes-scale-2 1.2
		modus-themes-scale-3 1.3
		modus-themes-scale-4 1.6
		modus-themes-scale-title 1.33)
  (modus-themes-load-operandi)
  )

(use-package doom-modeline
  :pin melpa
  :ensure t
  :config
  (set-face-foreground 'doom-modeline-buffer-modified "systemOrangeColorz")
  (set-face-foreground 'doom-modeline-buffer-major-mode "systemBrownColor")
  (set-face-foreground 'doom-modeline-buffer-minor-mode "systemBrownColor")
  (set-face-foreground 'doom-modeline-project-dir "systemBrownColor")
  (set-face-foreground 'doom-modeline-project-root-dir "systemBrownColor")
  (set-face-foreground 'doom-modeline-project-parent-dir "systemBrownColor")
  (set-face-foreground 'doom-modeline-project-dir "systemBrownColor") ;; project name
  (set-face-foreground 'doom-modeline-buffer-file "systemBrownColor")

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

(set-face-foreground 'line-number "darkgrey")

(use-package display-fill-column-indicator
  :pin manual
  :custom
  (display-fill-column-indicator-column 100)
  (display-fill-column-indicator-character ?\u2502)
  ;; :init
  ;; (global-display-fill-column-indicator-mode t)
  )

(use-package beacon
  :pin melpa
  :ensure t
  :init
  (setq beacon-color "sandybrown")
  :config
  (beacon-mode 1)
  )

(provide 'init-ui)
