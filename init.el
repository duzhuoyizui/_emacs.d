(package-initialize)

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

(setq load-prefer-newer t)
(setq package-load-list '(all))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)
(setq use-package-always-pin t)

;;----------------------------------------------------------------------------
;; Base config
;;----------------------------------------------------------------------------
(setq user-full-name "JerryZhang"
      user-mail-address "m@zhangjiee.com")

;; (setq debug-on-error t) ; Produce backtraces when errors occur => default close

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/lisp/")
;; (require 'init-benchmarking)

(require 'init-env)
(require 'init-common)
(require 'init-db)
(require 'init-docker)
(require 'init-flycheck)
(require 'init-hydra)
(require 'init-lsp)
(require 'init-markdown)
(require 'init-nginx)
(require 'init-org)
(require 'init-python)
(require 'init-ui)
(require 'init-web)
(require 'init-yaml)

;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))
