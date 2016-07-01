;;------------------------------------------------------------------------------
;; 包管理工具初始化
;;------------------------------------------------------------------------------
(require 'package)

(add-to-list 'package-archives
             '("popkit" . "https://elpa.popkit.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(defvar myPackages
  '(better-defaults
    auto-complete
    auto-yasnippet
    highlight-symbol
    fill-column-indicator
    window-numbering
    expand-region
    markdown-mode
    vue-mode
    js3-mode
    web-mode
    flycheck
    go-mode
    helm
    helm-projectile
    indent-guide
    emmet-mode))

(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)

;;------------------------------------------------------------------------------
;; 基本配置(独立于插件)
;;------------------------------------------------------------------------------
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

(global-set-key [(f3)] 'eshell)
(global-set-key [(f4)] 'insert-current-date-time)
(global-set-key [(f5)] 'compile)

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

(setq linum-format "%3d|")
;;(global-linum-mode 1)
(global-set-key (kbd "M-s l") 'global-linum-mode)

(require 'fill-column-indicator)
(setq fci-rule-color "#eee")
(setq fci-rule-column 80)
(define-globalized-minor-mode
  global-fci-mode fci-mode (lambda () (fci-mode 1)))
;;(global-fci-mode 1)

;; color: http://raebear.net/comp/emacscolors.html
;; (global-hl-line-mode t)
;; (set-face-background 'hl-line "snow")

(load-theme 'whiteboard t)


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

(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
(setq ac-menu-height 8)
(add-to-list 'ac-modes 'js3-mode)

(require 'yasnippet)
(yas-global-mode 1)

(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x r b") 'helm-filtered-bookmarks)
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

(require 'helm-projectile)
(helm-projectile-on)

;;------------------------------------------------------------------------------
;; go
;;------------------------------------------------------------------------------
(require 'go-mode-autoloads)


;;------------------------------------------------------------------------------
;; Python
;;------------------------------------------------------------------------------


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
(setq web-mode-enable-current-element-highlight t)

(require 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'html-mode-hook 'emmet-mode)

(global-set-key (kbd "M-e") nil)
(global-set-key (kbd "M-e p") 'emmet-prev-edit-point)
(global-set-key (kbd "M-e n") 'emmet-next-edit-point)

;;------------------------------------------------------------------------------
;; js3-mode
;;------------------------------------------------------------------------------
(autoload 'js3-mode "js3" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))

;;------------------------------------------------------------------------------
;; Flycheck
;;------------------------------------------------------------------------------
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(add-hook 'python-mode-hook (lambda ()
                              (flycheck-mode 1)
                              (setq flycheck-checker 'python-pylint
                                    flycheck-checker-error-threshold 900
                                    flycheck-pylintrc "~/.pylintrc")))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js3-auto-indent-p t)
 '(js3-curly-indent-offset 2)
 '(js3-enter-indents-newline t)
 '(js3-expr-indent-offset 2)
 '(js3-lazy-commas t)
 '(js3-lazy-operators t)
 '(js3-paren-indent-offset 2)
 '(js3-square-indent-offset 2)
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
