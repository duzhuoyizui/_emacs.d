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
(setq indicate-empty-lines t) ;; Show a marker in the left fringe for lines not in the buffer
(setq show-trailing-whitespace t)
(blink-cursor-mode 0)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(column-number-mode t) ; show column number
(global-set-key (kbd "M-s l") 'display-line-numbers-mode)

(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'set-scroll-bar-mode)
    (set-scroll-bar-mode nil))
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))

(setq-default indent-tabs-mode nil)
(show-paren-mode t)
(save-place-mode 1)

(load-theme 'leuven)

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
                      :height 160
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
