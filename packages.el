;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; (package! lsp-treemacs :disable t)
;; (package! coffee-mode :disable t)
;; (package! stylus-mode :disable t)

;; Temporarily support formatting BASH/TOML/.., untested compatibility
;; (package! format-all :pin "18b97bbcb9")

(package! command-log-mode)
(package! xah-fly-keys)
(package! valign)
;; (package! protobuf-mode)
(package! apheleia)
(package! prettier)
(when (modulep! :editor format +prettier-deprecated)
  (package! prettier-js))
(package! js-doc)
(when (modulep! :tools tree-sitter)
  (package! jsdoc :pin "2e7c02ff2dc422bc21c405bd90a7092c2f599630" :recipe
    (:host github
     :repo "isamert/jsdoc.el"
     :files ("jsdoc.el"))))
(when (modulep! :lang rest)
  (package! restclient-jq :pin "abc307b965bf6720bc466281f2e204cd5ce37dc3" :recipe
    (:host github
     :repo "pashky/restclient.el"
     :files ("restclient-jq.el"))))
(package! go-translate)
;; (package! youdao-dictionary)
(when (file-exists-p "~/.wakatime.cfg")
  (package! wakatime-mode))

(when (modulep! :lang solidity)
  (package! solidity-mode :pin "929ce58ff0d42cf1109f9fb0655c787ee58cc2da"))
(when (modulep! :completion company)
  (package! company-solidity))
(when (modulep! :checkers syntax)
  (package! solidity-flycheck :pin "929ce58ff0d42cf1109f9fb0655c787ee58cc2da"))
