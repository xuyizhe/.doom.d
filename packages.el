;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! lsp-treemacs :disable t)
(package! coffee-mode :disable t)
(package! stylus-mode :disable t)

(package! xah-fly-keys)
(package! prettier-js)
(package! youdao-dictionary)
(when (file-exists-p "~/.wakatime.cfg")
  (package! wakatime-mode))
