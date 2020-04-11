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

(provide 'init-ui)
