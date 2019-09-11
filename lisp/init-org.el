(use-package org
  :ensure t
  :defer 2
  :config
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
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
  )

;; blog
(require 'ox-publish)
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

(provide 'init-org)
