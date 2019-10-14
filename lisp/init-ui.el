;; 关闭启动消息
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(blink-cursor-mode 0)

(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

(setq visible-bell 1)
(setq ring-bell-function 'ignore)

;; Show a marker in the left fringe for lines not in the buffer
(setq indicate-empty-lines t)

;; NO tool bar
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
;; no scroll bar
(if (fboundp 'set-scroll-bar-mode)
    (set-scroll-bar-mode nil))
;; no menu bar
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))

(column-number-mode t) ; show column number

(global-set-key (kbd "M-s l") 'display-line-numbers-mode)

(load-theme 'leuven)

;; (use-package zenburn-theme
;;   :ensure t
;;   :config
;;   (load-theme 'zenburn t)
;;   )

(use-package rainbow-delimiters
  :ensure t
  :defer 1
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  (rainbow-delimiters-mode 1)
  )

(use-package powerline
  :ensure t
  :config
  (powerline-default-theme)
  )

;; Set default font
(cond
 ((string-equal system-type "gnu/linux")
  (set-face-attribute 'default nil
                      :family "WenQuanYi Zen Hei Mono"
                      :height 135
                      :weight 'normal
                      :width 'normal))
 ((string-equal system-type "darwin")
  (set-face-attribute 'default nil
                      :family "WenQuanYi Zen Hei Mono"
                      :height 170
                      :weight 'normal
                      :width 'normal))
 )

;; disable bold
(defadvice set-face-attribute
    (before no-bold (face frame &rest args) activate)
  (setq args
        (mapcar (lambda(x) (if (eq x 'bold) 'normal x))
                args)))

(use-package multiple-cursors
  :ensure t
  :defer 1
  :config
  (global-set-key (kbd "C-c C-e") 'mc/edit-lines)
  (global-set-key (kbd "C-c >") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-c <") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-a") 'mc/mark-all-like-this)
  (global-set-key (kbd "C-c a") 'mc/edit-beginnings-of-lines)
  (global-set-key (kbd "C-c e") 'mc/edit-ends-of-lines)
  )

;; (use-package beacon
;;   :ensure t
;;   :config
;;   (setq beacon-push-mark 35)
;;   (setq beacon-color "#666600")
;;   (beacon-mode t)
;;   )

;; (use-package wttrin
;;   :ensure t
;;   :defer t
;;   :config
;;   (setq wttrin-default-cities '("Hangzhou" "Hefei"))
;;   (setq wttrin-default-accept-language '("Accept-Language" . "zh-TW"))
;;   )

;; M-x all-the-icons-install-fonts to some dir
(use-package all-the-icons
  :ensure t
  :defer 0.5
  :config
  (setq inhibit-compacting-font-caches t)
  ;; debug: open this and mark it `eval-buffer`
  ;; (all-the-icons-insert-icons-for 'alltheicon)   ;; Prints all the icons for `alltheicon' font set
  ;; (all-the-icons-insert-icons-for 'octicon 10)   ;; Prints all the icons for the `octicon' family
  ;; (all-the-icons-insert-icons-for 'faicon 1 0.5) ;; Prints all the icons for the `faicon' family
  )

(use-package all-the-icons-ivy
  :ensure t
  :after (all-the-icons ivy)
  :custom (all-the-icons-ivy-buffer-commands '(ivy-switch-buffer-other-window ivy-switch-buffer))
  :config
  (setq all-the-icons-ivy-buffer-commands '())
  (all-the-icons-ivy-setup))

(use-package all-the-icons-dired
  :ensure t
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
  )

(provide 'init-ui)
