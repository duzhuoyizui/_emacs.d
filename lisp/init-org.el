(use-package htmlize
  :ensure t
  :defer t
  )

(use-package org
  :ensure t
  :defer t
  :config

  (setq org-log-done t)
  ;; GTD setting
  (setq org-todo-keywords
        '((sequence "TODO(t)" "BLOCK(b)" "|" "DONE(d)" "CANCELD(d)")))

  (use-package org-inlinetask)

  (use-package ob-go
    :ensure t
    )

  ;; programming languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (emacs-lisp . t)
     (css . t)
     (js . t)
     (org . t)
     (python . t)
     (sed . t)
     (sql . t)
     (R . t)
     (go . t)
     )
   )
  (use-package org-bullets
    :ensure t
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
    (org-bullets-mode 1)
    )

  (use-package ox-reveal
    :ensure t
    :config
    (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
    (global-set-key [(f12)] 'org-reveal-export-to-html-and-browse)
    (reveal-mode 1)
    )
  )

;; blog
(use-package ox-publish
  :defer t
  :config
  (setq org-html-validation-link nil)

  (setq org-publish-project-alist
        '(
          ;; notes component
          ("site-orgs"
           :base-directory "~/site/org"
           :base-extension "org"
           :html-link-home "index.html"
           :publishing-directory "~/site-html/"
           :recursive t
           :publishing-function org-html-publish-to-html
           :headline-levels 5
           :auto-preamble t
           :auto-sitemap t
           :sitemap-filename "sitemap.org"
           :sitemap-title "Sitemap"
           )
          ;; static component
          ("site-static"
           :base-directory "~/site/static/"
           :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
           :publishing-directory "~/site-html/static/"
           :recursive t
           :publishing-function org-publish-attachment
           )
          ;; publish component
          ("site" :components ("site-orgs" "site-static"))
          ))

  )

(provide 'init-org)