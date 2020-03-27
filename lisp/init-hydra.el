(use-package hydra
  :pin melpa
  :ensure t
  :init
  (defhydra hydra-zoom (global-map "<f2>")
    "zoom"
    ("g" text-scale-increase "in")
    ("l" text-scale-decrease "out")
    ("=" enlarge-window-horizontally "enlarge-window-h")
    ("+" enlarge-window "enlarge-window-v")
    ("-" shrink-window-horizontally "shrink-window-h")
    ("_" shrink-window "shrink-window-v" )
    )

  (defhydra hydra-zhj-key (:pre (progn (message "enter v-edit mode"))
							  :post (progn (message "leave v-edit mode"))
							  :foreign-keys warn
							  :timeout 1
							  :idle 60
							  )
	"bydra zhj-key"
	;; basic move
	("k" previous-line "prev line")
	("j" next-line "next line")
	("l" forward-char "forward char")
	("h" backward-char "backward char")
	("a" move-beginning-of-line "move beginning of line")
	("e" move-end-of-line "move end of line")
	("[" beginning-of-buffer "beginning of buffer")
	("]" end-of-buffer "end of buffer")

	;; search
	("g" counsel-ag "ag search")

	;; projectile
	("pf" counsel-projectile-find-file "projectile find file")

	;; buffer
	("o" counsel-find-file "open file")
	("b" switch-to-buffer "ivy switch buffer")
	("w" save-buffer "save buffer")
	("s" swiper "search")

	("h" (hydra-set-property 'hydra-toggle :verbosity 1) :exit nil)
	("q" nil "quit")
	)
  (global-set-key (kbd "<f8>") 'hydra-zhj-key/body)
  )


(provide 'init-hydra)
