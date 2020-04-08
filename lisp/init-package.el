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

(require 'use-package)
(setq use-package-verbose t)
(setq use-package-always-pin t)

(provide 'init-package)
