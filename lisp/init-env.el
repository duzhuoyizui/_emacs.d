;; exec-path-from-shell is slow, so set [defer]
;; https://github.com/purcell/exec-path-from-shell/issues/36

(use-package exec-path-from-shell
  :ensure t
  :defer 1
  :config
  (when (and window-system
             (memq window-system '(mac ns)))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-env "GOPATH"))
  (progn (dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO"))
           (add-to-list 'exec-path-from-shell-variables var)))
  )

(provide 'init-env)
