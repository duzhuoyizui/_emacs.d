(use-package youdao-dictionary
  :pin melpa
  :ensure t
  :bind (("<f9> y p" . youdao-dictionary-search-at-point)
		 ("<f9> y i" . youdao-dictionary-search-from-input))
  :init
  (setq url-automatic-caching t)
  )

(provide 'init-dict)
