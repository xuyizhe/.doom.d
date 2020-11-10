;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! xah-fly-keys)
(package! prettier-js)
(package! youdao-dictionary)
(when (file-exists-p "~/.wakatime.cfg")
  (package! wakatime-mode))
