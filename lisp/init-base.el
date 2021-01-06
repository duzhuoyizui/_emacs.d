;;------------------------------------------------------------------------------
;; basic setting (non-package setting)
;;------------------------------------------------------------------------------
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


(add-hook 'text-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (setq tab-width 4)))
(setq indent-line-function (quote insert-tab))

(setq-default tab-width 4)
(fset 'yes-or-no-p 'y-or-n-p)
(electric-pair-mode nil)
(electric-indent-mode 1)
;; (electric-quote-mode 1)

(save-place-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq visible-bell nil)
(setq ring-bell-function 'ignore)

(global-auto-revert-mode t)

(provide 'init-base)
