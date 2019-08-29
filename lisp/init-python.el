;; python
;; jedi + company-jedi
;;
;; How get all python standard library path ?
;; >>> import sys
;; >>> sys.path


(use-package python
  :ensure t
  :init
  (set-variable 'py-indent-offset 4)
  (set-variable 'python-indent-guess-indent-offset nil)

  :config
  ;; (use-package company-jedi
  ;;   :ensure t
  ;;   :init
  ;;   (add-hook 'python-mode-hook 'jedi:setup)

  ;;   :config
  ;;   (setq jedi:complete-on-dot t)
  ;;   (setq jedi:use-shortcuts t)
  ;;   (setq jedi:tooltip-method nil)

  ;;   (setq jedi:server-args
  ;;         (list
  ;;          ;; Ubuntu 18.10
  ;;          "--sys-path" "/usr/lib/python3.6"
  ;;          "--sys-path" (expand-file-name "~/.local/lib/python3.6/site-packages")
  ;;          ;; macOS
  ;;          "--sys-path" "/usr/local/Cellar/python/3.7.3/Frameworks/Python.framework/Versions/3.7/lib/python3.7"
  ;;          "--sys-path" "/usr/local/Cellar/python/3.7.4/Frameworks/Python.framework/Versions/3.7/lib/python3.7"
  ;;          "--sys-path" "/usr/local/lib/python3.7/site-packages"
  ;;          ))
  ;;   )
)


(provide 'init-python)
