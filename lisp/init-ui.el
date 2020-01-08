;;----------------------------------------------------------------------------
;; UI: 编辑器显示
;;----------------------------------------------------------------------------
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq use-dialog-box nil)
(setq use-file-dialog nil)
(setq visible-bell 1)
(setq blink-cursor-mode 0)
(setq indicate-empty-lines t) ;; Show a marker in the left fringe for lines not in the buffer
(setq show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(column-number-mode t) ; show column number
(global-set-key (kbd "M-s l") 'display-line-numbers-mode)

(load-theme 'leuven)

;; better-defaults include feature:
;;   turned off  toolbar, menu bar, and scroll bar
;;   uniquify library
;;   show-paren-mode 1
;;   save-place-mode 1
;;   indent-tabls-mode nil
(use-package better-defaults
  :ensure t
  )

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  (rainbow-delimiters-mode 1)
  )

(use-package powerline
  :ensure t
  :config
  (powerline-default-theme)
  )

(use-package beacon
  :ensure t
  :config
  (setq beacon-blink-delay '0.2)
  (setq beacon-blink-when-focused 't)
  (setq beacon-dont-blink-commands 'nil)
  (setq beacon-color "#40a9ff")
  (beacon-mode 1)
  )

(use-package diminish
  :ensure t
  :config
  (diminish 'ivy-mode)
  (diminish 'flycheck-mode)
  (diminish 'company-mode)
  (diminish 'eldoc-mode)
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
                      :family "Microsoft YaHei Mono"
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


(provide 'init-ui)
