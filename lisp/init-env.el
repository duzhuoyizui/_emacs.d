;; exec-path-from-shell 很慢，所以延迟加载
;; 非终端，GUI 环境下要如果需要执行命令，比如 git 需要：=exec-path-from-shell-initialize=
;; https://github.com/purcell/exec-path-from-shell/issues/36

(use-package exec-path-from-shell
  :pin melpa
  :ensure t
  :defer t
  :config
  (when (and window-system
             (memq window-system '(mac ns)))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-env "GOPATH"))
  (progn (dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO"))
           (add-to-list 'exec-path-from-shell-variables var)))
  )

(provide 'init-env)
