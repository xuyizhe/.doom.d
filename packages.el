;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! lsp-treemacs :disable t)
(package! coffee-mode :disable t)
(package! stylus-mode :disable t)

;; Temporarily support formatting BASH/TOML/.., untested compatibility
;; (package! format-all :pin "18b97bbcb9")

(package! xah-fly-keys)
(package! valign)
(package! protobuf-mode)
(when (featurep! :editor format +prettier-force)
  (package! prettier-js))
(when (featurep! :lang rest)
  (package! restclient-jq :pin "abc307b965bf6720bc466281f2e204cd5ce37dc3" :recipe
    (:host github
     :repo "pashky/restclient.el"
     :files ("restclient-jq.el"))))
(package! youdao-dictionary)
(when (file-exists-p "~/.wakatime.cfg")
  (package! wakatime-mode))
