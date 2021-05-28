
;; http://martinowen.net/blog/2010/02/03/tips-for-emacs-ibuffer.html

(global-set-key (kbd "C-x C-b") 'ibuffer) ;; Use Ibuffer for Buffer List

(setq ibuffer-saved-filter-groups
      '(("home"
		 ("emacs-config" (or (filename . ".emacs.d")))
		 ("Org" (or (mode . org-mode)))
         ("Go" (or (mode . go-mode)))
		 ("Web" (or (mode . html-mode)
					(mode . rjsx-mode)
					(mode . js-mode)
					(mode . less-mode)
					(mode . css-mode)))
		 ("Other" (or (name . "\*Help\*")
					 (name . "\*Apropos\*")
					 (name . "\*info\*"))))))

(setq ibuffer-show-empty-filter-groups nil)
(add-hook 'ibuffer-mode-hook
		  '(lambda ()
			 (ibuffer-auto-mode 1)
			 (ibuffer-switch-to-saved-filter-groups "home")))

(provide 'init-ibuffer)
