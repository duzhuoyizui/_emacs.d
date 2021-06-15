(require 'package)

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
		("melpa" . "https://melpa.org/packages/")
		("melpa-stable" . "http://stable.melpa.org/packages/")
		("org" . "https://orgmode.org/elpa/")))

;; use http proxy
(setq url-proxy-services
      '(("http" . "127.0.0.1:1088")
        ("https" . "127.0.0.1:1088")))

;; in china
;; (setq package-archives
;;       '(("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;; 		("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
;; 		("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")
;; 		("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-and-compile
  (setq use-package-verbose t)
  (setq use-package-always-pin t)
  (setq use-package-compute-statistics t)
  (setq use-package-hook-name-suffix nil)
  )

(eval-when-compile
  (require 'use-package))

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

(add-to-list 'load-path "~/.emacs.d/lisp/")

(require 'init-base)
(require 'init-dict)
(require 'init-dired)
(require 'init-keybinding)
(require 'init-ui)
(require 'init-edit)
(require 'init-env)
(require 'init-flycheck)
(require 'init-ibuffer)
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
