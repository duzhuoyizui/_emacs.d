;; expand-region
;; https://github.com/magnars/expand-region.el
(use-package expand-region
  :ensure t
  :defer 5
  :config
  (global-set-key (kbd "M-m") 'er/expand-region)
  (global-set-key (kbd "M-s s") 'er/mark-symbol)
  (global-set-key (kbd "M-s p") 'er/mark-outside-pairs)
  (global-set-key (kbd "M-s P") 'er/mark-inside-pairs)
  (global-set-key (kbd "M-s q") 'er/mark-outside-quotes)
  (global-set-key (kbd "M-s Q") 'er/mark-inside-quotes)
  (global-set-key (kbd "M-s m") 'er/mark-comment)
  (global-set-key (kbd "M-s f") 'er/mark-defun)
  )
(provide 'init-expand-region)
