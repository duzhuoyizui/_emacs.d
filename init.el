(package-initialize)

;; Produce backtraces when errors occur => default close
;; (setq debug-on-error t)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(setq gc-cons-threshold 100000000)

(require 'init-package)
(require 'init-base)
(require 'init-keybinding)
(require 'init-ui)
(require 'init-edit)
(require 'init-env)
(require 'init-flycheck)
(require 'init-lsp-lang)
(require 'init-markdown)
(require 'init-nginx)
(require 'init-db)
(require 'init-docker)
(require 'init-web)
(require 'init-yaml)
(require 'init-plantuml)
(require 'init-org)

;; variables configured via the interactive 'customize' interface
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))
