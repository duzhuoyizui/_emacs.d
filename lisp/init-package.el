(require 'package)

(setq url-proxy-services
      '(
        ("http" . "127.0.0.1:1088")
        ("https" . "127.0.0.1:1088")
        ))

(setq package-archives
      '(
        ;; GNU ELPA
        ("gnu" . "http://elpa.gnu.org/packages/")
        ;; ("melpa" . "https://melpa.org/packages/")
        ("melpa-stable" . "http://stable.melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")

        ;; tsinghua mirror repository
        ;; ("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ;; ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ;; ("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")
        ))

(unless package-archive-contents
  (package-refresh-contents))

(setq load-prefer-newer t)

(setq package-load-list '(all))

(unless (package-installed-p 'org)
  (package-install 'org))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(package-initialize)

(require 'use-package)
(setq use-package-verbose t)

(provide 'init-package)
