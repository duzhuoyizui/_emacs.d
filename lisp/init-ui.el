;;----------------------------------------------------------------------------
;; UI 编辑器显示
;;----------------------------------------------------------------------------
;; (cond
;;  ((string-equal system-type "gnu/linux")
;;   (set-face-attribute 'default nil
;;                       :family "Microsoft YaHei Mono"
;;                       :height 150
;;                       :weight 'normal
;;                       :width 'normal))
;;  ((string-equal system-type "darwin")
;;   (set-face-attribute 'default nil
;;                       :family "Microsoft YaHei Mono"
;;                       :height 165
;;                       :weight 'normal
;;                       :width 'normal))
;;  )

;; disable bold
(defadvice set-face-attribute
    (before no-bold (face frame &rest args) activate)
  (setq args
        (mapcar (lambda(x) (if (eq x 'bold) 'normal x))
                args)))

(load-theme 'leuven)

;; 需要安装 all-the-icons: =M-x all-the-icons-install-fonts=
;; (use-package doom-modeline
;;   :pin melpa
;;   :ensure t
;;   :defer 0.5
;;   :init
;;   (setq doom-modeline-project-detection 'ffip)
;;   (setq doom-modeline-buffer-modification-icon nil)
;;   :config
;;   (set-face-foreground 'doom-modeline-buffer-modified "sandybrown")
;;   (doom-modeline-mode 1)
;;   )

(use-package rainbow-delimiters
  :pin melpa
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode)
  )

(use-package beacon
  :pin melpa
  :ensure t
  :defer 0.5
  :diminish
  :init
  (setq beacon-blink-delay '0.2)
  (setq beacon-blink-when-focused 't)
  (setq beacon-dont-blink-commands 'nil)
  (setq beacon-color "#40a9ff")
  :config
  (beacon-mode 1)
  )

(provide 'init-ui)
