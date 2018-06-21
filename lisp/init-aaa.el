;; 独立于插件的配置

(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
            '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

(fset 'yes-or-no-p 'y-or-n-p)
(setq auto-save-default nil)
(menu-bar-mode -1)
(setq inhibit-startup-message t)
(setq mouse-yank-at-point t)
(setq make-backup-files nil)
(setq create-lockfiles nil)
(column-number-mode t)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(global-auto-revert-mode t)
(show-paren-mode t)
(save-place-mode 1)
(electric-pair-mode 1)  ; 括号自动补全

(setq show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; 插入当前时间
(defvar current-date-time-format "%Y-%m-%d %H:%M:%S"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defvar current-time-format "%a %H:%M:%S"
  "Format of date to insert with `insert-current-time' func.
Note the weekly scope of the command's precision.")

(defun insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
  (interactive)
  (insert (format-time-string current-date-time-format (current-time)))
  )

(defun insert-current-time ()
  "insert the current time (1-week scope) into the current buffer."
  (interactive)
  (insert (format-time-string current-time-format (current-time)))
  (insert "\n")
  )

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(global-set-key [(f3)] 'eshell)
(global-set-key [(f4)] 'insert-current-date-time)
(global-set-key [(f5)] 'compile)
(global-set-key [(f6)] 'show-file-name)

(provide 'init-aaa)
