
(require 'company)
(require 'company-go)

(add-hook 'after-init-hook 'global-company-mode)
(global-company-mode)

(setq company-transformers '(company-sort-by-occurrence))
(setq company-echo-delay 0)
(setq company-idle-delay 0)

(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

;; only go mode use company-go
(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))

(provide 'init-company)
