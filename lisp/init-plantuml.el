(use-package plantuml-mode
  :pin melpa
  :ensure t
  :defer t
  :init
  (setq plantuml-jar-path "/usr/local/bin/plantuml.jar")
  (setq plantuml-default-exec-mode 'jar)
  (add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
  )

(provide 'init-plantuml)
