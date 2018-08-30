(require 'go-mode)
(require 'go-guru)

(add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)

(defun go-mode-setup ()
  (setq gofmt-command "goimports")
  (setq compile-command "go build -v && go test -v && go vet")
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'go-mode-setup)


(provide 'init-go)
