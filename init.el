;;------------------------------------------------------------------------------
;; 包管理工具初始化
;;------------------------------------------------------------------------------

(require 'package)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(add-to-list 'package-archives
             '("popkit" . "http://elpa.popkit.org/packages/"))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    auto-complete
    helm
    ace-jump-mode
    highlight-symbol
    fill-column-indicator
    window-numbering
    expand-region
    markdown-mode
    yaml-mode
    vue-mode
    js2-mode
    web-mode
    flycheck
    bm
    jedi
    emmet-mode
    exec-path-from-shell
    helm-projectile
    neotree
    )
  )

(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;;------------------------------------------------------------------------------
;; 基本配置(独立于插件)
;;------------------------------------------------------------------------------
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
(setq show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(show-paren-mode t)
(save-place-mode 1)
;;(electric-pair-mode 1)  ; 括号自动补全

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
(global-set-key (kbd "<f2>") 'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)

(global-unset-key (kbd "C-z"))

(defun align-to-equals (begin end)
  "Align region to equal signs"
  (interactive "r")
  (align-regexp begin end "\\(\\s-*\\)=" 1 1 ))
(global-set-key (kbd "C-c a =") 'align-to-equals)


(blink-cursor-mode -1)

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(set-default-font "Monaco 15")

;;------------------------------------------------------------------------------
;; 外观
;;------------------------------------------------------------------------------
(global-visual-line-mode 1)

(setq linum-format "%3d| ")
;;(global-linum-mode 1)
(global-set-key (kbd "M-s l") 'global-linum-mode)

(require 'fill-column-indicator)
(setq fci-rule-color "#F0F0F0")
(setq fci-rule-column 80)
(define-globalized-minor-mode
  global-fci-mode fci-mode (lambda () (fci-mode 1)))
;;(global-fci-mode 1)

;; color: http://raebear.net/comp/emacscolors.html
;; (global-hl-line-mode t)
;; (set-face-background 'hl-line "gainsboro")

(load-theme 'leuven t)

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

(add-to-list 'ac-modes 'js2-mode)

(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c h o") 'helm-occur)

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-buffers-fuzzy-matching           t
      helm-recentf-fuzzy-match              t
      helm-M-x-fuzzy-match                  t
      )

(helm-mode 1)

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; helm-projectile
(projectile-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-switch-project-action 'helm-projectile)

(setq bm-highlight-style 'bm-highlight-only-line)


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

(require 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'html-mode-hook 'emmet-mode)

(global-set-key (kbd "M-e") nil)
(global-set-key (kbd "M-e p") 'emmet-prev-edit-point)
(global-set-key (kbd "M-e n") 'emmet-next-edit-point)

;;------------------------------------------------------------------------------
;; Flycheck
;;------------------------------------------------------------------------------
(require 'flycheck)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
(add-hook 'after-init-hook #'global-flycheck-mode)
;; (add-hook 'python-mode-hook (lambda ()
;;                               (flycheck-mode 1)
;;                               (setq flycheck-checker 'python-pylint
;;                                     flycheck-checker-error-threshold 900
;;                                     flycheck-pylintrc "~/.pylintrc")))

(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

(flycheck-add-mode 'javascript-eslint 'web-mode)
;; customize flycheck temp file prefix
;; (setq-default flycheck-temp-prefix ".flycheck")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (neotree shell-here yaml-mode window-numbering web-mode vue-mode markdown-mode js2-mode jedi highlight-symbol go-mode flycheck fill-column-indicator expand-region exec-path-from-shell emmet-mode bm better-defaults ace-jump-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
