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
(global-unset-key (kbd "C-\\")) ;; disable toggle input method

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

;; align with spaces only
;; https://stackoverflow.com/questions/915985/in-emacs-how-to-line-up-equals-signs-in-a-series-of-initialization-statements/8129994
(defadvice align-regexp (around align-regexp-with-spaces)
  "Never use tabs for alignment."
  (let ((indent-tabs-mode nil))
    ad-do-it))
(ad-activate 'align-regexp)

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))


(global-set-key (kbd "M-s l") 'display-line-numbers-mode)
(global-set-key (kbd "M-s n") 'display-fill-column-indicator-mode)
(global-set-key (kbd "M-*") 'match-paren)

(global-set-key (kbd "<f9> 1") 'delete-other-windows)
(global-set-key (kbd "<f9> 2") 'split-window-below)
(global-set-key (kbd "<f9> 3") 'split-window-horizontally)
(global-set-key (kbd "<f9> a") 'backward-sentence)
(global-set-key (kbd "<f9> c") 'eshell)
(global-set-key (kbd "<f9> d") 'kill-whole-line)
(global-set-key (kbd "<f9> e") 'forward-sentence)
(global-set-key (kbd "<f9> r") 'query-replace)
(global-set-key (kbd "<f9> g a") 'align-regexp)
(global-set-key (kbd "<f9> g d") 'insert-current-date-time)
(global-set-key (kbd "<f9> g l") 'lgrep) ;; search in current dir
(global-set-key (kbd "<f9> g r") 'rgrep) ;; search in current dir and sub-dir
(global-set-key (kbd "<f9> m") 'counsel-imenu)
(global-set-key (kbd "<f9> w") 'save-buffer)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(provide 'init-keybinding)
