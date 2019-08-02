(use-package go-mode
  :ensure t
  :defer 5
  :config
  (defun go-mode-setup ()
    (setq gofmt-command "goimports")
    (setq compile-command "go build -v && go test -v && go vet")
    (setq gofmt-command "goimports")
    (add-hook 'before-save-hook 'gofmt-before-save)
    (local-set-key (kbd "M-.") 'godef-jump))
  (add-hook 'go-mode-hook 'go-mode-setup)

  (use-package go-guru
    :ensure t
    :config
    (add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)
    )
  )
(provide 'init-go)
