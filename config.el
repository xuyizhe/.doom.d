;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "xuyizhe"
      user-mail-address "barrenbass@gmail.com")

(add-hook 'emacs-startup-hook 'toggle-frame-maximized)

(setq doom-theme 'doom-one)

(setq org-directory "~/org/")

(setq display-line-numbers-type t)

(use-package! xah-fly-keys
  :init
  (setq xah-fly-use-control-key nil)
  :config
  (xah-fly-keys-set-layout "qwerty")
  (define-key xah-fly-command-map (kbd "C-. y y") #'youdao-dictionary-search-at-point-posframe)
  (define-key xah-fly-command-map (kbd "C-. y v") #'youdao-dictionary-play-voice-at-point)
  (define-key xah-fly-command-map (kbd "C-. y i") #'youdao-dictionary-search-from-input)
  (define-key xah-fly-command-map (kbd "C-. d d") #'dap-debug)
  (define-key xah-fly-command-map (kbd "C-. d s") #'dap-ui-show-many-windows)
  (define-key xah-fly-command-map (kbd "C-. d t") #'dap-breakpoint-toggle)
  (xah-fly-keys 1))

(use-package! prettier-js
  :hook ((web-mode css-mode json-mode js2-mode typescript-mode) . prettier-js-mode)
  :config
  (setq prettier-js-show-errors "echo")
  (setq prettier-js-args
        '("--trailing-comma" "es5"
          "--single-quote" "true"
          "--arrow-parens" "always")))

(after! dap-mode
  (setq dap-cpptools-debug-program `("~/.vscode/extensions/ms-vscode.cpptools-1.1.0/debugAdapters/OpenDebugAD7"))
  (require 'dap-cpptools))

(after! youdao-dictionary
  (setq url-automatic-caching t)
  (setq youdao-dictionary-search-history-file "~/.emacs.d/.youdao"))
