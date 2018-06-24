;; -*- coding: utf-8 -*-
(package-initialize)

(let ((minver "25.1"))
  (when (version< emacs-version minver)
    (error "This config requires Emacs v%s or higher" minver)))

;;------------------------------------------------------------------------------
;; 基本配置(独立于插件)
;;------------------------------------------------------------------------------
(defmacro require-init (pkg)
  `(load (file-truename (format "~/.emacs.d/lisp/%s" ,pkg))))

(let ((file-name-handler-alist nil))
  (require-init 'init-elpa) ;; must to be top

  (require-init 'init-aaa)
  (require-init 'init-complete)
  (require-init 'init-env)
  (require-init 'init-expand-region)
  (require-init 'init-flycheck)
  (require-init 'init-go)
  (require-init 'init-helm)
  (require-init 'init-highlight-symbol)
  (require-init 'init-keyfreq)
  (require-init 'init-markdown)
  (require-init 'init-python)
  (require-init 'init-ui)
  (require-init 'init-web)
  (require-init 'init-window)
  (require-init 'init-yaml)
  )

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
