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

;; via: https://github.com/redguardtoo/emacs.d/blob/master/init.el
(setq gc-cons-percentage 0.6)
(setq gc-cons-threshold most-positive-fixnum)
;; @see https://www.reddit.com/r/emacs/comments/55ork0/is_emacs_251_noticeably_slower_than_245_on_windows/
;; Emacs 25 does gc too frequently
;; (setq garbage-collection-messages t) ; for debug
(defun my-cleanup-gc ()
  "Clean up gc."
  (setq gc-cons-threshold  67108864) ; 64M
  (setq gc-cons-percentage 0.1) ; original value
  (garbage-collect))

(run-with-idle-timer 4 nil #'my-cleanup-gc)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(require 'init-base)
(require 'init-keybinding) ;; must be top than other <f1>-><12> binding
(require 'init-dict)
(require 'init-dired)
(require 'init-ui)
(require 'init-edit)
(require 'init-env)
(require 'init-flycheck)
(require 'init-feed)
(require 'init-ibuffer)
(require 'init-vc)
(require 'init-lang)
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
