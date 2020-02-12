(use-package hydra
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
  )

(provide 'init-hydra)
