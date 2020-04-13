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
  (define-key evil-normal-state-map [escape] 'keyboard-quit)
  (define-key evil-visual-state-map [escape] 'keyboard-quit)
  (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
  (global-set-key [escape] 'evil-exit-emacs-state)

  (use-package evil-leader
	:pin melpa
	:ensure t
	:init
	(setq evil-leader/leader ",")
	(evil-leader/set-key
	  "0" 'delete-window
	  "1" 'delete-other-windows
	  "2" 'split-window-below
	  "3" 'split-window-right
	  "a" 'ace-window
	  "b" 'switch-to-buffer
	  "c f" 'counsel-find-file
	  "c g" 'counsel-git
	  "c j" 'counsel-git-grep
	  "c k" 'counsel-ag
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
	  "s t" 'ace-swap-window
	  "u t" 'undo-tree-visualize
	  "w" 'save-buffer
	  "x" 'eshell
	  )
	:config
	(global-evil-leader-mode)
	)

  (evil-mode 1)
  )

;; via https://gist.github.com/penn201500/fd445603ea05faef4c9f5b2e102613ad
;; In normal state auto switching to english input
;; when entering insert/replace state switch back
;; based on im-select(https://github.com/daipeihust/im-select)
;; use /usr/local/bin/im-select check current input code
(defvar default-im "com.apple.keylayout.US" "Default Mac ascii-only input method")

(defvar prev-im (substring (shell-command-to-string "/usr/local/bin/im-select") 0 -1)
  "IM that I use when starting Emacs and exiting insert mode")

(defun im-use-english()
  "switch to US input method"
  (interactive)
  (cond ((eq system-type 'darwin)
		 (call-process-shell-command (concat "/usr/local/bin/im-select " default-im)))))

(defun im-remember ()
  "Remember the input method being used in insert mode,
so we can switch to it in other modes."
  (interactive)
  (cond ((eq system-type 'darwin)
         (setq prev-im (substring (shell-command-to-string "/usr/local/bin/im-select") 0 -1)))))

(defun im-use-prev ()
  "Use previous input method.
If previous input method is not defined, use default method"
  (interactive)
  (cond ((eq system-type 'darwin)
         (if prev-im
             (call-process-shell-command (concat "/usr/local/bin/im-select " prev-im))
           (call-process-shell-command (concat "/usr/local/bin/im-select " default-im))))))

(add-hook 'evil-normal-state-entry-hook 'im-use-english)
(add-hook 'evil-insert-state-entry-hook 'im-use-prev)
(add-hook 'evil-insert-state-exit-hook 'im-remember)
(add-hook 'evil-replace-state-entry-hook 'im-use-prev)
(add-hook 'evil-replace-state-exit-hook 'im-remember)
(add-hook 'evil-emacs-state-entry-hook 'im-use-english)

(provide 'init-evil)
