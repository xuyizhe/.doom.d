;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "xuyizhe"
      user-mail-address "barrenbass@gmail.com")

;; (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
;;                          ("melpa" . "http://elpa.emacs-china.org/melpa/")
;;                          ("org" . "http://elpa.emacs-china.org/org/")))
;; (setq package-archives '(("gnu" . "http://mirrors.ustc.edu.cn/elpa/gnu/")
;;                          ("melpa" . "http://mirrors.ustc.edu.cn/elpa/melpa/")
;;                          ("org" . "http://mirrors.ustc.edu.cn/elpa/org/")))
;; (setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;                          ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
;;                          ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))
;; (package-initialize)

(add-hook 'emacs-startup-hook 'toggle-frame-maximized)

(setq doom-theme 'doom-one)

(setq org-directory "~/org/")

(setq display-line-numbers-type t)

(use-package! wakatime-mode
  :init
  (global-wakatime-mode))

;; (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

(use-package! xah-fly-keys
  :init
  (setq xah-fly-use-control-key nil)
  :config
  (xah-fly-keys-set-layout "qwerty")
  (define-key xah-fly-command-map (kbd "C-. l d") #'lsp-ui-peek-find-definitions)
  (define-key xah-fly-command-map (kbd "C-. l r") #'lsp-ui-peek-find-references)
  (define-key xah-fly-command-map (kbd "C-. y y") #'youdao-dictionary-search-at-point-posframe)
  (define-key xah-fly-command-map (kbd "C-. y v") #'youdao-dictionary-play-voice-at-point)
  (define-key xah-fly-command-map (kbd "C-. y i") #'youdao-dictionary-search-from-input)
  (define-key xah-fly-command-map (kbd "C-. d d") #'dap-debug)
  (define-key xah-fly-command-map (kbd "C-. d c") #'dap-continue)
  (define-key xah-fly-command-map (kbd "C-. d i") #'dap-step-in)
  (define-key xah-fly-command-map (kbd "C-. d o") #'dap-step-out)
  (define-key xah-fly-command-map (kbd "C-. d r") #'dap-debug-restart)
  (define-key xah-fly-command-map (kbd "C-. d s") #'dap-stop-thread)
  (define-key xah-fly-command-map (kbd "C-. d k") #'dap-delete-session)
  (define-key xah-fly-command-map (kbd "C-. d w") #'dap-ui-show-many-windows)
  (define-key xah-fly-command-map (kbd "C-. d t") #'dap-breakpoint-toggle)
  (xah-fly-keys 1))

(after! web-mode
  (setq web-mode-script-padding 0)
  (setq web-mode-style-padding 0))

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
  (setq youdao-dictionary-search-history-file "~/.youdao"))

(after! racer
  (setq racer-rust-src-path
      (let* ((sysroot (string-trim
                       (shell-command-to-string "rustc --print sysroot")))
             (lib-path (concat sysroot "/lib/rustlib/src/rust/library"))
              (src-path (concat sysroot "/lib/rustlib/src/rust/src")))
        (or (when (file-exists-p lib-path) lib-path)
            (when (file-exists-p src-path) src-path)))))
