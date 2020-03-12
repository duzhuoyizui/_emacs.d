;;----------------------------------------------------------------------------
;; UI 编辑器显示
;;----------------------------------------------------------------------------
(use-package cnfonts
  :pin melpa
  :ensure t
  :init
  (setq cnfonts-personal-fontnames '(("JetBrains Mono")))
  (setq cnfonts-profiles '("default"))
  (setq cnfonts-use-system-type t)        ; different os different config dir
  (setq cnfonts-use-face-font-rescale t)
  (cnfonts-enable)
  )

;; disable bold
(defadvice set-face-attribute
    (before no-bold (face frame &rest args) activate)
  (setq args
        (mapcar (lambda(x) (if (eq x 'bold) 'normal x))
                args)))

(use-package doom-themes
  :pin melpa
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  ;; for dark mode
  (global-set-key (kbd "M-s D")
                (lambda () (interactive)
                  (load-theme 'doom-one t)))

  ;; for light mode
  (global-set-key (kbd "M-s L")
                (lambda () (interactive)
                  (load-theme 'doom-one-ligh t)))

  (load-theme 'doom-one t)

  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

;; 需要安装 all-the-icons: =M-x all-the-icons-install-fonts=
(use-package doom-modeline
  :pin melpa
  :ensure t
  :init (doom-modeline-mode 1))

(use-package all-the-icons-ivy
  :pin melpa
  :ensure t
  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))

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
