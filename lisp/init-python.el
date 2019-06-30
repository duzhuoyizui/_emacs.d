;; company-jedi
;; Github: https://github.com/syohex/emacs-company-jedi

(use-package python
  :init
  (set-variable 'py-indent-offset 4)
  (set-variable 'python-indent-guess-indent-offset nil)
  (defun my/python-mode-hook ()
    (add-to-list 'company-backends 'company-jedi))
  (add-hook 'python-mode-hook 'my/python-mode-hook)

  :config
  (use-package company-jedi
    :ensure t
    :init
    (add-hook 'python-mode-hook 'jedi:setup)

    :config
    (setq jedi:complete-on-dot t)
    (setq jedi:use-shortcuts t)
    (setq jedi:tooltip-method nil)

    (setq jedi:server-args
          '(
            ;; Ubuntu 18.04
            "--sys-path" "/usr/lib/python3.6"
            ;; "--sys-path" expand-file-name "~/.local/lib/python3.6/site-packages"
            "--sys-path" "/home/jerryzhang/.local/lib/python3.6/site-packages"
            ))
    )
)


(provide 'init-python)
