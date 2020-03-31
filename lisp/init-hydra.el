(defvar current-date-time-format "%Y-%m-%d %H:%M:%S %a"
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

(defun hydra-nobinding ()
  "hydra-nobinding prompt"
  (interactive)
  (message "hydra bind nothing")
  )

(use-package hydra
  :pin melpa
  :ensure t
  :init

  (defhydra hydra-ext (global-map "<f8>"
								  :pre (progn (message "right start >>"))
								  :post (progn (message "left end !"))
								  :foreign-keys warn
								  :timeout 1
								  :idle 60
								  :hint nil
								  :exit t
								  )
	"right hand start, left end !"
	("r" ivy-resume "ivy resume")
	("t" insert-current-date-time "insert current date time")
	("x" eshell "open eshell")

	;; for org mode move
	("w" org-metaup "org meta up")
	("a" org-metaleft "org meta left")
	("s" org-metadown "org meta down")
	("d" org-metaright "org meta right")

	;; projectile
	("b" counsel-projectile-switch-to-buffer "switch buffer in project")

	("<f8>" nil "quit")
	)

  (defhydra hydra-left (global-map "<f2>"
								   :pre (progn (message "left start >>>>"))
								   :post (progn (message "right end !"))
								   :foreign-keys warn
								   :timeout 1
								   :idle 60
								   :hint nil
								   :exit t
								   )
	"left hand start, right hand end"
	("+" enlarge-window "enlarge-window-v")
	("-" shrink-window-horizontally "shrink-window-h")
	("=" enlarge-window-horizontally "enlarge-window-h")
	("_" shrink-window "shrink-window-v")
	("l" display-line-numbers-mode "line number")
	("m" counsel-semantic-or-imenu "show imenu")
	("ol" org-toggle-link-display "org toggle link display")
	("of" org-footnote-new "new org footnote")
	("p" show-file-name "display path")

	("<f2>" nil "quit")
	)
  )

(provide 'init-hydra)
