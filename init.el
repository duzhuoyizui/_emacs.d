;;------------------------------------------------------------------------------
;; 包管理工具初始化
;;------------------------------------------------------------------------------

(require 'package)

(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(exec-path-from-shell
    better-defaults
    auto-complete
    helm
    highlight-symbol
    window-numbering
    expand-region
    markdown-mode
    yaml-mode
    js2-mode
    web-mode
    flycheck
    jedi
    emmet-mode
    bm
    smart-mode-line
    go-mode
    go-guru
    go-rename
    go-autocomplete
    )
  )

(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

;;------------------------------------------------------------------------------
;; 基本配置(独立于插件)
;;------------------------------------------------------------------------------
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
            '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

(fset 'yes-or-no-p 'y-or-n-p)
(setq auto-save-default nil)
(menu-bar-mode -1)
(setq inhibit-startup-message t)
(setq mouse-yank-at-point t)
(setq make-backup-files nil)
(setq create-lockfiles nil)
(column-number-mode t)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(global-auto-revert-mode t)
(show-paren-mode t)
(save-place-mode 1)
;;(electric-pair-mode 1)  ; 括号自动补全

(setq show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; 插入当前时间
(defvar current-date-time-format "%Y-%m-%d %H:%M:%S"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defvar current-time-format "%a %H:%M:%S"
  "Format of date to insert with `insert-current-time' func.
Note the weekly scope of the command's precision.")

(defun insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
  (interactive)
  (insert (format-time-string current-date-time-format (current-time)))
  )

(defun insert-current-time ()
  "insert the current time (1-week scope) into the current buffer."
  (interactive)
  (insert (format-time-string current-time-format (current-time)))
  (insert "\n")
  )

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(global-set-key [(f3)] 'eshell)
(global-set-key [(f4)] 'insert-current-date-time)
(global-set-key [(f5)] 'compile)
(global-set-key [(f6)] 'show-file-name)

(global-set-key (kbd "<f12>") 'bm-toggle)
(global-set-key (kbd "<f11>") 'bm-next)
(global-set-key (kbd "<S-f11>") 'bm-previous)
(global-unset-key (kbd "C-z"))

(defun align-to-equals (begin end)
  "Align region to equal signs"
  (interactive "r")
  (align-regexp begin end "\\(\\s-*\\)=" 1 1 ))
(global-set-key (kbd "C-c a =") 'align-to-equals)

;;------------------------------------------------------------------------------
;; 外观
;;------------------------------------------------------------------------------
(global-visual-line-mode 1)
(global-set-key (kbd "M-s l") 'global-linum-mode)

(setq sml/no-confirm-load-theme t)
(setq sml/theme 'light)
(sml/setup)

(load-theme 'leuven)

;;------------------------------------------------------------------------------
;; 打开文件，缓冲区切换优化
;;------------------------------------------------------------------------------
;; 使用 M-(1,2,3...9)窗口切换
(require 'window-numbering)
(setq window-numbering-assign-func
      (lambda () (when (equal (buffer-name) "*Calculator*") 9)))
(window-numbering-mode 1)

;;------------------------------------------------------------------------------
;; expand-region
;;------------------------------------------------------------------------------
(require 'expand-region)
(global-set-key (kbd "M-m") 'er/expand-region)
(global-set-key (kbd "M-s s") 'er/mark-symbol)
(global-set-key (kbd "M-s p") 'er/mark-outside-pairs)
(global-set-key (kbd "M-s P") 'er/mark-inside-pairs)
(global-set-key (kbd "M-s q") 'er/mark-outside-quotes)
(global-set-key (kbd "M-s Q") 'er/mark-inside-quotes)
(global-set-key (kbd "M-s m") 'er/mark-comment)
(global-set-key (kbd "M-s f") 'er/mark-defun)

;;------------------------------------------------------------------------------
;; 相同符号高亮
;;------------------------------------------------------------------------------
(require 'highlight-symbol)
(global-set-key (kbd "M--") 'highlight-symbol-at-point)
(global-set-key (kbd "M-n") 'highlight-symbol-next)
(global-set-key (kbd "M-p") 'highlight-symbol-prev)

;;------------------------------------------------------------------------------
;; auto-complate && yasnippet && helm
;;------------------------------------------------------------------------------
(require 'auto-complete)
(global-auto-complete-mode t)

(setq ac-auto-show-menu t)
(setq ac-use-menu-map t)
(setq ac-menu-height 8)
(setq ac-use-quick-help nil)

(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
(global-set-key "\M-/" 'auto-complete)

(add-to-list 'ac-modes 'web-mode)

(require 'helm)
(require 'helm-config)

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c h o") 'helm-occur)

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(setq helm-autoresize-max-height 40)
(setq helm-autoresize-min-height 40)
(helm-autoresize-mode 1)

(helm-mode 1)

;;------------------------------------------------------------------------------
;; Python
;;------------------------------------------------------------------------------
(add-hook 'python-mode-hook 'jedi:setup)
(set-variable 'py-indent-offset 4)
(set-variable 'python-indent-guess-indent-offset nil)
(setq jedi:complete-on-dot t)
(setq jedi:use-shortcuts t)
(setq jedi:server-args
      '("--sys-path" "/usr/local/lib/python3.6/site-packages/"))
(setq jedi:tooltip-method nil)


;;------------------------------------------------------------------------------
;; golang
;;------------------------------------------------------------------------------
(require 'go-mode)

(require 'go-guru)

(require 'go-rename)

(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

(defun go-mode-setup ()
  (setq gofmt-command "goimports")
  (setq compile-command "go build -v && go test -v && go vet")
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'go-mode-setup)

;;------------------------------------------------------------------------------
;; Markdown
;;------------------------------------------------------------------------------
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.markdown" . markdown-mode) auto-mode-alist))

;;------------------------------------------------------------------------------
;; YAML
;;------------------------------------------------------------------------------
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;;------------------------------------------------------------------------------
;; web-mode(html, js, jsx, css)
;;------------------------------------------------------------------------------
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.xml?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))

(setq web-mode-enable-current-element-highlight t)

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)  ; HTML
  (setq web-mode-css-indent-offset 2)  ; CSS
  (setq web-mode-code-indent-offset 2) ; script/code
  (setq web-mode-script-padding 1)     ; html 内嵌 script 开头缩进
  )
(add-hook 'web-mode-hook 'my-web-mode-hook)

(setq web-mode-content-types-alist
      '(("jsx" . "\\.js[x]?\\'")))

(require 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'html-mode-hook 'emmet-mode)

(global-set-key (kbd "M-e") nil)
(global-set-key (kbd "M-e p") 'emmet-prev-edit-point)
(global-set-key (kbd "M-e n") 'emmet-next-edit-point)

;; less 额外处理
(add-to-list 'auto-mode-alist '("\\.less\\'" . css-mode))
(setq css-indent-offset 2)

;;------------------------------------------------------------------------------
;; Flycheck
;;------------------------------------------------------------------------------
(require 'flycheck)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
(add-hook 'after-init-hook #'global-flycheck-mode)

(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

(flycheck-add-mode 'javascript-eslint 'web-mode)

(setq flycheck-python-flake8-executable "flake8")

;;------------------------------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flycheck-pyflakes avy-flycheck yaml-mode window-numbering web-mode smart-mode-line markdown-mode js2-mode jedi highlight-symbol helm go-rename go-guru go-autocomplete flycheck expand-region exec-path-from-shell emmet-mode bm better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
