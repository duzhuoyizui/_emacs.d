;; company-jedi
;; Github: https://github.com/syohex/emacs-company-jedi

(add-hook 'python-mode-hook 'jedi:setup)
(set-variable 'py-indent-offset 4)
(set-variable 'python-indent-guess-indent-offset nil)
(setq jedi:complete-on-dot t)
(setq jedi:use-shortcuts t)
(setq jedi:server-args
      '("--sys-path" "/usr/local/lib/python3.6/site-packages/"))
(setq jedi:tooltip-method nil)

(provide 'init-python)
