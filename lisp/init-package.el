(require 'package)

(setq package-archives
	  '(("gnu" . "http://elpa.gnu.org/packages/")
		("melpa" . "https://melpa.org/packages/")
		("melpa-stable" . "http://stable.melpa.org/packages/")
		("org" . "https://orgmode.org/elpa/")))

;; use http proxy
;; (setq url-proxy-services
;;       '(("http" . "127.0.0.1:1088")
;;         ("https" . "127.0.0.1:1088")))

;; in china
;; (setq package-archives
;;       '(("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;; 		("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
;; 		("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")
;; 		("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-verbose t)
;; all package must set pin addr
(setq use-package-always-pin t)
;; if you want show package load time, open this and =M-x use-package-report= show load package time
(setq use-package-compute-statistics t)

(provide 'init-package)
