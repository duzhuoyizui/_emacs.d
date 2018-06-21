;; 窗口操作
;; window-numbering: 使用 M-(1,2,3...9)窗口切换

(require 'window-numbering)
(setq window-numbering-assign-func
      (lambda () (when (equal (buffer-name) "*Calculator*") 9)))
(window-numbering-mode 1)

(provide 'init-window)
