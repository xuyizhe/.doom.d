;;; xah-fly-keys/config.el -*- lexical-binding: t; -*-

(use-package! xah-fly-keys
  :init
  (setq xah-fly-use-control-key nil)
  :config
  (xah-fly-keys-set-layout "qwerty")
  (xah-fly-keys 1))
