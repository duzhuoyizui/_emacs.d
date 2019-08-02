;; markdown

(use-package markdown-mode
  :ensure t
  :defer 5
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init
  (setq markdown-command "markdown")
  (setq markdown-css-paths `(,(expand-file-name "~/.emacs.d/markdown.css")))
  )

(provide 'init-markdown)
