;; -*- coding: utf-8 -*-
(package-initialize)

(let ((minver "25.1"))
  (when (version< emacs-version minver)
    (error "This config requires Emacs v%s or higher" minver)))

(defvar best-gc-cons-threshold
  4000000
  "Best default gc threshold value.  Should NOT be too big!")

;; don't GC during startup to save time
(setq gc-cons-threshold most-positive-fixnum)

;;------------------------------------------------------------------------------
;; 基本配置(独立于插件)
;;------------------------------------------------------------------------------
(defmacro require-init (pkg)
  `(load (file-truename (format "~/.emacs.d/lisp/%s" ,pkg))))

(let ((file-name-handler-alist nil))
  (require-init 'init-elpa) ;; must to be top

  (require-init 'init-aaa)
  (require-init 'init-ace)
  (require-init 'init-complete)
  (require-init 'init-docker)
  (require-init 'init-env)
  (require-init 'init-expand-region)
  (require-init 'init-flycheck)
  (require-init 'init-go)
  (require-init 'init-highlight-symbol)
  (require-init 'init-project)
  (require-init 'init-python)
  (require-init 'init-ui)
  (require-init 'init-web)
  (require-init 'init-which-key)
  (require-init 'init-window)
  (require-init 'init-yaml)
  )

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
