;;------------------------------------------------------------------------------
;; global key binding
;;------------------------------------------------------------------------------
;; unset all function key
(global-unset-key (kbd "<f1>"))
(global-unset-key (kbd "<f2>"))
(global-unset-key (kbd "<f3>"))
(global-unset-key (kbd "<f4>"))
(global-unset-key (kbd "<f5>"))
(global-unset-key (kbd "<f6>"))
(global-unset-key (kbd "<f7>"))
(global-unset-key (kbd "<f8>"))
(global-unset-key (kbd "<f9>"))
(global-unset-key (kbd "<f10>"))
(global-unset-key (kbd "<f11>"))
(global-unset-key (kbd "<f12>"))

(defvar current-date-time-format "%Y-%m-%d %H:%M:%S"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defun insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
  (interactive)
  (insert (format-time-string current-date-time-format (current-time)))
  )

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

;; Align with spaces only
;; https://stackoverflow.com/questions/915985/in-emacs-how-to-line-up-equals-signs-in-a-series-of-initialization-statements/8129994
(defadvice align-regexp (around align-regexp-with-spaces)
  "Never use tabs for alignment."
  (let ((indent-tabs-mode nil))
    ad-do-it))
(ad-activate 'align-regexp)

(global-set-key (kbd "<f2>") 'display-line-numbers-mode)
(global-set-key (kbd "<f3>") 'eshell)
(global-set-key (kbd "<f4>") 'align-regexp)
(global-set-key (kbd "<f6>") 'show-file-name)
(global-set-key (kbd "<f7>") 'insert-current-date-time)
(global-set-key (kbd "<f12>") 'counsel-imenu)

(provide 'init-keybinding)
