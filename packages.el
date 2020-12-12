;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! lsp-treemacs :disable t)
(package! coffee-mode :disable t)
(package! stylus-mode :disable t)

;; Temporarily support formatting BASH/TOML/.., untested compatibility
;; (package! format-all :pin "18b97bbcb9")

(package! xah-fly-keys)
(when (featurep! :editor format +prettier-force)
  (package! prettier-js))
(package! youdao-dictionary)
(when (file-exists-p "~/.wakatime.cfg")
  (package! wakatime-mode))
