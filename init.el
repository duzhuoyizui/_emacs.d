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
  ;; all package must set pin addr
  (setq use-package-always-pin t)
  ;; if you want show package load time, open this and =M-x use-package-report= show load package time
  (setq use-package-compute-statistics t)

  ;; The following is VERY IMPORTANT.  Write hooks using their real name
  ;; instead of a shorter version: after-init ==> `after-init-hook'.
  ;;
  ;; This is to empower help commands with their contextual awareness,
  ;; such as `describe-symbol'.
  (setq use-package-hook-name-suffix nil)
  )

(eval-when-compile
  (require 'use-package))

(setq gc-cons-threshold 100000000)

(add-to-list 'load-path "~/.emacs.d/lisp/")

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
