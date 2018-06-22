;; company 自动补全

(require 'company)

;; markdown-mode, eshell-mode ignore complete
(setq company-global-modes '(not markdown-mode eshell-mode))

(add-hook 'after-init-hook 'global-company-mode)

(setq company-transformers '(company-sort-by-occurrence))
(setq company-echo-delay 0)
(setq company-idle-delay 0)

(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

(provide 'init-company)
