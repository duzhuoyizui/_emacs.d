;; 关闭启动消息
(setq inhibit-startup-message t)

;; no tool-bar, menu-bar, scroll-bar
(tool-bar-mode -1)
(menu-bar-mode -1)

(blink-cursor-mode 0)  ; no cursor blink
(column-number-mode t) ; show column number

(global-set-key (kbd "M-s l") 'display-line-numbers-mode)

(load-theme 'leuven)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(provide 'init-ui)
