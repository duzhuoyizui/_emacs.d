;; -*- coding: utf-8 -*-
(package-initialize)

;; Produce backtraces when errors occur => default close
;; (setq debug-on-error t)

(setq user-full-name "JerryZhang"
      user-mail-address "m@zhangjiee.com")

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-benchmarking)

;;----------------------------------------------------------------------------
;; Adjust garbage collection thresholds during startup, and thereafter
;;----------------------------------------------------------------------------
;; (defvar best-gc-cons-threshold
;;   4000000
;;   "Best default gc threshold value.  Should NOT be too big!")

;; don't GC during startup to save time
;; (setq gc-cons-threshold most-positive-fixnum)

;;----------------------------------------------------------------------------
;; Base config
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(require 'init-package)                    ; install required package, must be top
(require 'init-env)                        ; set system path

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require 'init-common)
(require 'init-complete)
(require 'init-docker)
(require 'init-expand-region)
(require 'init-flycheck)
(require 'init-go)
(require 'init-highlight-symbol)
(require 'init-project)
(require 'init-python)
(require 'init-ui)
(require 'init-web)
(require 'init-which-key)
(require 'init-window)
(require 'init-yaml)
(require 'init-markdown)

;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(when (file-exists-p custom-file)
  (load custom-file))
