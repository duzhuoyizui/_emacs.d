;; 系统环境

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(provide 'init-env)
