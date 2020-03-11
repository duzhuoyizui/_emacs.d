;;----------------------------------------------------------------------------
;; UI 编辑器显示
;;----------------------------------------------------------------------------

;; (require 'cnfonts)

;; (setq cnfonts-personal-fontnames '(("JetBrains Mono")))

;; ;; (10   12.0 12.0)
;; ;; (11.5 15.0 15.0)
;; ;; (12.5 15.0 15.0)
;; ;; (14   16.5 16.5)
;; ;; (15   18.0 18.0)
;; ;; (16   20.0 20.0)
;; ;; (18   22.0 22.0)
;; (set-face-attribute
;;  'default nil
;;  :font (font-spec :name "-*-JetBrains Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1"
;;                   :weight 'normal
;;                   :slant 'normal
;;                   :size 15))
;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;   (set-fontset-font
;;    (frame-parameter nil 'font)
;;    charset
;;    (font-spec :name "-*-Hiragino Sans GB-normal-normal-normal-*-*-*-*-*-p-0-iso10646-1"
;;               :weight 'normal
;;               :slant 'normal
;;               :size 18.0)))

;; ;; (setq cnfonts-use-face-font-rescale t)

;; ;; disable bold
;; (defadvice set-face-attribute
;;     (before no-bold (face frame &rest args) activate)
;;   (setq args
;;         (mapcar (lambda(x) (if (eq x 'bold) 'normal x))
;;                 args)))

;; (cnfonts-enable)

(cond
 ((string-equal system-type "gnu/linux")
  (set-face-attribute 'default nil
                      :family "Microsoft YaHei Mono"
                      :height 150
                      :weight 'normal
                      :width 'normal))
 ((string-equal system-type "darwin")
  (set-face-attribute 'default nil
                      :family "Microsoft YaHei Mono"
                      :height 165
                      :weight 'normal
                      :width 'normal))
 )
;; disable bold
(defadvice set-face-attribute
    (before no-bold (face frame &rest args) activate)
  (setq args
        (mapcar (lambda(x) (if (eq x 'bold) 'normal x))
                args)))


(load-theme 'leuven)

(use-package rainbow-delimiters
  :pin melpa
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  (rainbow-delimiters-mode 1)
  )

(use-package powerline
  :pin melpa
  :ensure t
  :config
  (powerline-default-theme)
  )

(use-package beacon
  :pin melpa
  :ensure t
  :config
  (setq beacon-blink-delay '0.2)
  (setq beacon-blink-when-focused 't)
  (setq beacon-dont-blink-commands 'nil)
  (setq beacon-color "#40a9ff")
  (beacon-mode 1)
  )

(use-package diminish
  :pin melpa
  :ensure t
  :config
  (diminish 'ivy-mode)
  (diminish 'flycheck-mode)
  (diminish 'company-mode)
  (diminish 'eldoc-mode)
  (diminish 'projectile-mode)
  )

(provide 'init-ui)
