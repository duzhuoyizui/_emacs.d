(global-visual-line-mode 1)
(global-set-key (kbd "M-s l") 'global-linum-mode)

(setq sml/no-confirm-load-theme t)
(setq sml/theme 'light)
(sml/setup)

(load-theme 'leuven)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(provide 'init-ui)
