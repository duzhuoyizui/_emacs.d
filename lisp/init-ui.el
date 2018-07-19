(global-set-key (kbd "M-s l") 'display-line-numbers-mode)

(require 'smart-mode-line)

(setq sml/no-confirm-load-theme t)
(setq sml/theme 'light)
(sml/setup)

(load-theme 'leuven)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(provide 'init-ui)
