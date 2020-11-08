;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "xuyizhe"
      user-mail-address "barrenbass@gmail.com")

(setq doom-theme 'doom-one)

(setq org-directory "~/org/")

(setq display-line-numbers-type t)

(use-package! xah-fly-keys
  :init
  (setq xah-fly-use-control-key nil)
  :config
  (xah-fly-keys-set-layout "qwerty")
  (xah-fly-keys 1))

(use-package! dap-mode
  :custom
  (dap-cpptools-debug-program `("~/.vscode/extensions/ms-vscode.cpptools-1.1.0/debugAdapters/OpenDebugAD7"))
  :config
  (require 'dap-cpptools))
