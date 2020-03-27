(setq user-full-name "JerryZhang"
      user-mail-address "m@zhangjiee.com")

(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; encode
(set-charset-priority 'unicode)
(setq locale-coding-system   'utf-8)
(set-terminal-coding-system  'utf-8)
(set-keyboard-coding-system  'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system        'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

(setq confirm-kill-emacs  'y-or-n-p
      auto-save-default    nil
      mouse-yank-at-point  t
      make-backup-files    nil
      indent-tabs-mode     nil
      create-lockfiles     nil)

(setq-default tab-width 4)

(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t)

(electric-pair-mode nil)
(electric-indent-mode 1)
;; (electric-quote-mode 1)

(setq inhibit-startup-echo-area-message t
      inhibit-startup-message t
      ring-bell-function 'ignore
      use-dialog-box nil
      use-file-dialog nil
      visible-bell 1
      indicate-empty-lines t
      show-trailing-whitespace t)

(blink-cursor-mode 0)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(column-number-mode t) ; show column number

(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'set-scroll-bar-mode)
    (set-scroll-bar-mode nil))
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))

(show-paren-mode t)
(save-place-mode 1)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(provide 'init-base)
