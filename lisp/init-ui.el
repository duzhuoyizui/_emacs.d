;; 关闭启动消息
(setq inhibit-startup-message t)

(menu-bar-mode -1)

(column-number-mode t) ; show column number

(global-set-key (kbd "M-s l") 'display-line-numbers-mode)

(load-theme 'leuven)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(provide 'init-ui)
