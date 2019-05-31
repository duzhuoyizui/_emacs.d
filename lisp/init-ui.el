;; 关闭启动消息
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(blink-cursor-mode 0)

;; Show a marker in the left fringe for lines not in the buffer
(setq indicate-empty-lines t)

;; NO tool bar
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
;; no scroll bar
(if (fboundp 'set-scroll-bar-mode)
    (set-scroll-bar-mode nil))
;; no menu bar
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))

(column-number-mode t) ; show column number

(global-set-key (kbd "M-s l") 'display-line-numbers-mode)

(load-theme 'leuven)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(require 'powerline)
(powerline-default-theme)

;; Set default font
(set-face-attribute 'default nil
                    :family "Source code pro"
                    :height 145
                    :weight 'normal
                    :width 'normal)
(set-face-bold 'bold nil)

(provide 'init-ui)
