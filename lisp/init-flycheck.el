(use-package flycheck
  :ensure t
  :defer 2
  :init
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint)))

  (cond
   ((string-equal system-type "gnu/linux")
    (setq flycheck-javascript-eslint-executable "/home/jerryzhang/qwerty-client/src/node_modules/eslint/bin/eslint.js")
    )
   ((string-equal system-type "darwin")
    (setq flycheck-javascript-eslint-executable "eslint")
    ))
  (setq flycheck-python-flake8-executable "flake8")
  (global-flycheck-mode)
  :config
  ;;(flycheck-add-mode 'javascript-eslint 'web-mode)
  )

(provide 'init-flycheck)
