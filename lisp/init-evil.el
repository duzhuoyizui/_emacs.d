(defvar current-date-time-format "%Y-%m-%d %H:%M:%S %a"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defun insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
  (interactive)
  (insert (format-time-string current-date-time-format (current-time)))
  )

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(use-package evil
  :pin melpa
  :ensure t
  :init
  (setq evil-want-C-i-jump nil)
  (setq evil-emacs-state-cursor '("red" box))
  (setq evil-normal-state-cursor '("green" box))
  (setq evil-visual-state-cursor '("orange" box))
  (setq evil-insert-state-cursor '("red" bar))
  (setq evil-replace-state-cursor '("red" bar))
  (setq evil-operator-state-cursor '("red" hollow))
  :config
  ;;(evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle)
  (define-key evil-normal-state-map [escape] 'keyboard-quit)
  (define-key evil-visual-state-map [escape] 'keyboard-quit)
  (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
  (global-set-key [escape] 'evil-exit-emacs-state)
  (evil-mode 1)
  )

(use-package evil-leader
  :pin melpa
  :ensure t
  :init
  (setq
   evil-leader/leader ","
   evil-leader/in-all-states 1
   )
  (evil-leader/set-key
	"+" 'enlarge-window
	"-" 'shrink-window-horizontally
	"0" 'delete-window
	"1" 'delete-other-windows
	"2" 'split-window-below
	"3" 'split-window-right
	"=" 'enlarge-window-horizontally
	"_" 'shrink-window
	"b" 'switch-to-buffer
	"c f" 'counsel-find-file
	"c g" 'counsel-git
	"c j" 'counsel-git-grep
	"c k" 'counsel-ag
	"c x" 'counsel-M-x
	"c y" 'counsel-yank-pop
	"e" 'find-file
	"i p" 'show-file-name
	"i t" 'insert-current-date-time
	"k" 'kill-buffer
	"l" 'display-line-numbers-mode
	"m" 'counsel-semantic-or-imenu
	"o a" 'org-metaleft
	"o d" 'org-metaright
	"o f" 'org-footnote-new
	"o l" 'org-toggle-link-display
	"o s" 'org-metadown
	"o w" 'org-metaup
	"p b" 'counsel-projectile-switch-to-buffer
	"p d" 'counsel-projectile-find-dir
	"p f" 'counsel-projectile-find-file
	"p i" 'projectile-invalidate-cache
	"p p" 'counsel-projectile-switch-project
	"q" 'save-buffers-kill-terminal
	"s ." 'swiper-isearch-thing-at-point
	"s s" 'swiper
	"u t" 'undo-tree-visualize
	"w" 'save-buffer
	"x" 'eshell
	)
  :config
  (global-evil-leader-mode)
  )

(provide 'init-evil)
