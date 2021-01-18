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
                      :family "Sarasa Mono SC"
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
  (set-face-foreground 'doom-modeline-buffer-modified "sandybrown")
  (setq doom-modeline-buffer-modification-icon nil)
  (setq doom-modeline-project-detection 'project)
  (setq doom-modeline-buffer-file-name-style 'truncate-all)
  (setq doom-modeline-enable-word-count t)
  (doom-modeline-mode 1)
  )

(use-package rainbow-delimiters
  :pin melpa
  :ensure t
  :hook (prog-mode-hook . rainbow-delimiters-mode)
  )

;; (use-package zenburn-theme
;;   :pin melpa
;;   :ensure t
;;   :config
;;   ;; use variable-pitch fonts for some headings and titles
;;   (setq zenburn-use-variable-pitch t)
;;   ;; scale headings in org-mode
;;   (setq zenburn-scale-org-headlines t)
;;   ;; scale headings in outline-mode
;;   (setq zenburn-scale-outline-headlines t)
;;   (load-theme 'zenburn t)
;;   )

(load-theme 'leuven)

(set-face-foreground 'line-number "darkgrey")

(use-package display-fill-column-indicator
  :pin manual
  :custom
  (display-fill-column-indicator-column 100)
  (display-fill-column-indicator-character ?\u2502)
  ;; :init
  ;; (global-display-fill-column-indicator-mode t)
  )

(use-package hl-todo
  :pin melpa
  :ensure t
  :config
  (setq hl-todo-keyword-faces
		'(("TODO" . "#FF0000")
          ("FIXME" . "#FF0000")))
  :init
  (global-hl-todo-mode t)
  )

(provide 'init-ui)
