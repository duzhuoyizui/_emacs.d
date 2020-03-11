(package-initialize)

; Produce backtraces when errors occur => default close
;; (setq debug-on-error t)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/lisp/")

(require 'init-base)
(require 'init-global-key)

(require 'init-package)
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

(require 'init-org)

;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))
