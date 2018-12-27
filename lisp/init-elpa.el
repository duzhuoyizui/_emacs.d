;;------------------------------------------------------------------------------
;; 安装依赖包
;;------------------------------------------------------------------------------
(require 'package)

(package-initialize)

(defvar melpa-include-packages
  '(
    company
    company-go
    company-jedi
    dockerfile-mode
    emmet-mode
    exec-path-from-shell
    expand-region
    flycheck
    go-guru
    go-mode
    go-rename
    helm
    highlight-symbol
    js2-mode
    keyfreq
    markdown-mode
    rainbow-delimiters
    rjsx-mode
    web-mode
    window-numbering
    yaml-mode
    )
  "Packages to install from melpa-unstable.")

(defvar melpa-stable-banned-packages nil
  "Banned packages from melpa-stable")

(setq package-archives
      '(("localelpa" . "~/.emacs.d/localelpa/")
        ;; uncomment below line if you need use GNU ELPA
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")

        ;; Use either 163 or tsinghua mirror repository when official melpa
        ;; is too slow or shutdown.

        ;; ;; {{ Option 1: 163 mirror repository:
        ;; ;; ("gnu" . "https://mirrors.163.com/elpa/gnu/")
        ;; ("melpa" . "https://mirrors.163.com/elpa/melpa/")
        ;; ("melpa-stable" . "https://mirrors.163.com/elpa/melpa-stable/")
        ;; ;; }}

        ;; ;; {{ Option 2: tsinghua mirror repository
        ;; ;; @see https://mirror.tuna.tsinghua.edu.cn/help/elpa/ on usage:
        ;; ;; ("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ;; ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ;; ("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")
        ;; }}
        ))

;;------------------------------------------------------------------------------
;; Internal implementation, newbies should NOT touch code below this line!
;;------------------------------------------------------------------------------

;; Patch up annoying package.el quirks
(defadvice package-generate-autoloads (after close-autoloads (name pkg-dir) activate)
  "Stop package.el from leaving open autoload files lying around."
  (let* ((path (expand-file-name (concat
                                  ;; name is string when emacs <= 24.3.1,
                                  (if (symbolp name) (symbol-name name) name)
                                  "-autoloads.el") pkg-dir)))
    (with-current-buffer (find-file-existing path)
      (kill-buffer nil))))

(defun package-filter-function (package version archive)
  "Optional predicate function used to internally filter packages used by package.el.
  The function is called with the arguments PACKAGE VERSION ARCHIVE, where
  PACKAGE is a symbol, VERSION is a vector as produced by `version-to-list', and
  ARCHIVE is the string name of the package archive."
  (let* (rlt)
    (cond
     ((string= archive "melpa-stable")
      (setq rlt (not (memq package melpa-stable-banned-packages))))
     ((string= archive "melpa")
      ;; We still need use some unstable packages
      (setq rlt (or (string-match-p (format "%s" package)
                                    (mapconcat (lambda (s) (format "%s" s)) melpa-include-packages " "))
                    ;; color themes are welcomed
                    (string-match-p "-theme" (format "%s" package)))))
     (t
      ;; I'm not picky on other repositories
      (setq rlt t)))
    rlt))

(defadvice package--add-to-archive-contents
    (around filter-packages (package archive) activate)
  "Add filtering of available packages using `package-filter-function'."
  (if (package-filter-function (car package)
                               (funcall (if (fboundp 'package-desc-version)
                                            'package--ac-desc-version
                                          'package-desc-vers)
                                        (cdr package))
                               archive)
      ad-do-it))

;; On-demand installation of packages
(defun require-package (package &optional min-version no-refresh)
  "Ask elpa to install given PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

;;------------------------------------------------------------------------------
;; Fire up package.el and ensure the following packages are installed.
;;------------------------------------------------------------------------------
(require-package 'company)
(require-package 'company-go)
(require-package 'company-jedi)
(require-package 'dockerfile-mode)
(require-package 'emmet-mode)
(require-package 'exec-path-from-shell)
(require-package 'expand-region)
(require-package 'flycheck)
(require-package 'go-guru)
(require-package 'go-mode)
(require-package 'go-rename)
(require-package 'helm)
(require-package 'highlight-symbol)
(require-package 'js2-mode)
(require-package 'keyfreq)
(require-package 'markdown-mode)
(require-package 'rainbow-delimiters)
(require-package 'rjsx-mode)
(require-package 'smart-mode-line)
(require-package 'web-mode)
(require-package 'window-numbering)
(require-package 'yaml-mode)

(provide 'init-elpa)
