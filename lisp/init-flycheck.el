(use-package flycheck
  :pin melpa
  :ensure t
  :defer t
  :diminish
  :init
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint)))

  ;; set flycheck tool
  (cond
   ((string-equal system-type "gnu/linux")
    (setq flycheck-javascript-eslint-executable "/home/jerryzhang/qwerty-client/src/node_modules/eslint/bin/eslint.js")
    )
   ((string-equal system-type "darwin")
    (setq flycheck-javascript-eslint-executable "eslint")
    ))
  (setq flycheck-python-flake8-executable "flake8")

  :config
  (global-flycheck-mode)
  ;;(flycheck-add-mode 'javascript-eslint 'web-mode)
  )

(provide 'init-flycheck)
