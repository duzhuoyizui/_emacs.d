;; company-jedi
;; Github: https://github.com/syohex/emacs-company-jedi

(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)

(provide 'init-python)
