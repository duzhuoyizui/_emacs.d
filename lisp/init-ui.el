;;----------------------------------------------------------------------------
;; UI 编辑器显示
;;----------------------------------------------------------------------------
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
  :hook (prog-mode . rainbow-delimiters-mode)
  )

(use-package beacon
  :pin melpa
  :ensure t
  :diminish
  :hook (prog-mode . beacon-mode)
  :init
  (setq beacon-blink-delay '0.2)
  (setq beacon-blink-when-focused 't)
  (setq beacon-dont-blink-commands 'nil)
  (setq beacon-color "#40a9ff")
  )

(provide 'init-ui)
