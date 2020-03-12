;;----------------------------------------------------------------------------
;; UI 编辑器显示
;;----------------------------------------------------------------------------
(require 'cnfonts)

(setq cnfonts-personal-fontnames '(("JetBrains Mono")))

(setq cnfonts-profiles '("default"))
(setq cnfonts-use-system-type t)        ; different os different config dir
(setq cnfonts-use-face-font-rescale t)

(cnfonts-enable)

;; disable bold
(defadvice set-face-attribute
    (before no-bold (face frame &rest args) activate)
  (setq args
        (mapcar (lambda(x) (if (eq x 'bold) 'normal x))
                args)))

;; old config
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

(use-package doom-themes
  :pin melpa
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one-light t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))


(use-package doom-modeline
  :pin melpa
  :ensure t
  :init (doom-modeline-mode 1))

(use-package rainbow-delimiters
  :pin melpa
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  (rainbow-delimiters-mode 1)
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

(provide 'init-ui)
