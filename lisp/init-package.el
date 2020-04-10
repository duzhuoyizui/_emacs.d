(require 'package)

(setq url-proxy-services
      '(
        ("http" . "127.0.0.1:1088")
        ("https" . "127.0.0.1:1088")
        ))

(setq package-archives
      '(
        ("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("melpa-stable" . "http://stable.melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        )
      )

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))


(eval-when-compile
  (require 'use-package))
(setq use-package-verbose t)
(setq use-package-always-pin t)

(require 'diminish)
(diminish 'eldoc-mode)
(diminish 'anaconda-eldoc-mode)
(diminish 'edebug-mode)
(diminish 'flycheck-mode)
(diminish 'helm-mode)
(diminish 'helm)
(diminish 'rainbow-delimiters-mode)
(diminish 'python-mode)
(diminish 'eldoc-mode)
(diminish 'git-gutter-mode)
(diminish 'git-gutter+-mode)
(diminish 'git-rebase-mode)
(diminish 'git-gutter-mode-major-mode)
(diminish 'magit-mode)
(diminish 'python)
(diminish 'elpy-mode)
(diminish 'projectile-mode)
(diminish 'git-gutter-mode)
(diminish 'flymake-mode)
(diminish 'ispell-minor-mode)
(diminish 'server-buffer-clients)
(diminish 'js2-mode)
(diminish 'company-mode)
(diminish 'ivy-mode)
(diminish 'undo-tree-mode)
(diminish 'lisp-mode)
(diminish 'editorconfig-mode)
(diminish 'whole-line-or-region-mode)
(diminish 'compilation-mode)
(diminish 'emacs-lisp-mode)
(diminish 'makefile-mode)

(require 'bind-key)

(provide 'init-package)
