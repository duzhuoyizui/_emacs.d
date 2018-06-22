(require 'flycheck)

(global-flycheck-mode)

(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

(flycheck-add-mode 'javascript-eslint 'web-mode)

(setq flycheck-javascript-eslint-executable "eslint")
(setq flycheck-python-flake8-executable "flake8")

(provide 'init-flycheck)
