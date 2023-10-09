;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "xuyizhe"
      user-mail-address "barrenbass@gmail.com"
      display-line-numbers-type t
      doom-theme 'doom-solarized-dark
      doom-font (font-spec :family "JetBrains Mono" :size 18 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 17)
      ;; ivy-posframe-font (font-spec :family "JetBrainsMono" :size 14)
      company-idle-delay 0)

(setq lsp-ui-sideline-enable nil
      lsp-enable-symbol-highlighting nil
      lsp-rust-analyzer-cargo-load-out-dirs-from-check t
      lsp-rust-analyzer-proc-macro-enable t)

(setq org-directory "~/org/"
      org-agenda-files '("~/org/gtd")
      org-noter-notes-search-path '("~/org/notes/"))

(setq sql-postgres-login-params
      `((user :default ,(user-login-name))
        (database :default "postgres")
        (server :default "localhost")
        (port :default 5432)))

(setq sql-mysql-login-params
      `((user :default ,(user-login-name))
        (database :default "mysql")
        (server :default "localhost")
        (port :default 3306)))

;; https://github.com/doomemacs/doomemacs/issues/4106#issuecomment-713205419
(setq +format-on-save-enabled-modes
      '(not emacs-lisp-mode  ; elisp's mechanisms are good enough
            sql-mode         ; sqlformat is currently broken
            tex-mode         ; latexindent is broken
            web-mode
            latex-mode))

(setq eldoc-idle-delay 0.75)
;; (setq company-idle-delay 0.75)
(setq flymake-no-changes-timeout 0.5)
(setq flycheck-solidity-solium-soliumrcfile "~/.soliumrc.json")
(setq gts-translate-list '(("en" "zh")))

(blink-cursor-mode)

;; formatter
(apheleia-global-mode +1)

(global-set-key (kbd "C-c C-t") 'gts-do-translate)

(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; (add-to-list 'initial-frame-alist '(top . 50))
;; (add-to-list 'initial-frame-alist '(left . 200))
;; (add-to-list 'initial-frame-alist '(width . 120))
;; (add-to-list 'initial-frame-alist '(height . 50))
;; (add-to-list 'initial-frame-alist '(fullscreen . fullheight))
;; (add-to-list 'default-frame-alist '(width . 120))
;; (add-to-list 'default-frame-alist '(height . 50))
;; (add-to-list 'default-frame-alist '(fullscreen . fullheight))

;; (remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

(add-hook 'sql-interactive-mode-hook #'yas-minor-mode)

;; https://github.com/doomemacs/doomemacs/issues/4106#issuecomment-715895606
(setq-hook! 'web-mode-hook +format-with 'prettier-prettify)
;; (add-hook 'after-init-hook #'global-prettier-mode)

;; https://zenn.dev/hyakt/articles/5c947cc22c4bfa
;; https://emacs-china.org/t/volar-eglot/21255
(setq-default eglot-events-buffer-size 0)
(define-derived-mode vue-mode web-mode "Vue")
(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
(add-hook 'vue-mode-hook 'eglot-ensure)
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(vue-mode . ("vue-language-server" "--stdio"
                                                    :initializationOptions
                                                    (:typescript (:tsdk "node_modules/typescript/lib"))))))

(when (modulep! :checkers spell +aspell)
  (setq ispell-extra-args
        '("--sug-mode=ultra"
          "--lang=en_US"
          "--run-together"))
  (ispell-change-dictionary "en_US" t))

(when (modulep! :tools lookup)
  (add-to-list '+lookup-provider-url-alist '("Actix-web issues" "https://github.com/actix/actix-web/issues?q=is%%3Aissue+%s"))
  (add-to-list '+lookup-provider-url-alist '("Docker" "https://docs.docker.com/search/?q=%s"))
  (add-to-list '+lookup-provider-url-alist '("Google" "https://www.google.com/search?ie=utf-8&oe=utf-8&q=%s"))
  (add-to-list '+lookup-provider-url-alist '("Reddit" "https://www.reddit.com/search/?q=%s"))
  (add-to-list '+lookup-provider-url-alist '("Crates" "https://crates.io/search?q=%s"))
  (add-to-list '+lookup-provider-url-alist '("MDN" "https://developer.mozilla.org/en-US/search?q=%s"))
  (add-to-list '+lookup-provider-url-alist '("NPM" "https://www.npmjs.com/search?q=%s"))
  (add-to-list '+lookup-provider-url-alist '("Zhihu" "https://www.zhihu.com/search?type=content&q=%s")))

(when (modulep! :editor file-templates)
  (add-to-list '+file-templates-alist '(restclient-mode))
  (set-file-template! "/tsconfig\\.json$" :trigger "__tsconfig.json" :mode 'json-mode)
  (set-file-template! "/lerna\\.json$" :trigger "__lerna.json" :mode 'json-mode)
  (set-file-template! "/webdriver\\.json$" :trigger "__webdriver.json" :mode 'json-mode))

(when (modulep! :lang latex)
  (setq-default TeX-engine 'xetex)
  (setenv "PATH" (concat "/Library/TeX/texbin:" (getenv "PATH")))
  (add-to-list 'exec-path "/Library/TeX/texbin"))

(use-package! valign
  :hook (org-mode . valign-mode))

(after! rustic
  (define-key rustic-mode-map (kbd "C-c C-c C-x C-x") 'rustic-cargo-test-rerun))

(use-package! wakatime-mode
  :when (file-exists-p "~/.wakatime.cfg")
  :init
  (global-wakatime-mode))

 (use-package! xah-fly-keys
  :init
  (setq xah-fly-use-control-key nil)
  (setq xah-fly-use-meta-key nil)
  (add-hook 'yas-before-expand-snippet-hook 'xah-fly-insert-mode-activate)
  :config
  (define-key xah-fly-shared-map (kbd "C-. l d") #'lsp-ui-peek-find-definitions)
  (define-key xah-fly-shared-map (kbd "C-. l r") #'lsp-ui-peek-find-references)
  (define-key xah-fly-shared-map (kbd "C-. y y") #'youdao-dictionary-search-at-point-posframe)
  (define-key xah-fly-shared-map (kbd "C-. y v") #'youdao-dictionary-play-voice-at-point)
  (define-key xah-fly-shared-map (kbd "C-. y i") #'youdao-dictionary-search-from-input)
  (define-key xah-fly-shared-map (kbd "C-. d d") #'dap-debug)
  (define-key xah-fly-shared-map (kbd "C-. d c") #'dap-continue)
  (define-key xah-fly-shared-map (kbd "C-. d i") #'dap-step-in)
  (define-key xah-fly-shared-map (kbd "C-. d o") #'dap-step-out)
  (define-key xah-fly-shared-map (kbd "C-. d r") #'dap-debug-restart)
  (define-key xah-fly-shared-map (kbd "C-. d s") #'dap-stop-thread)
  (define-key xah-fly-shared-map (kbd "C-. d k") #'dap-delete-session)
  (define-key xah-fly-shared-map (kbd "C-. d w") #'dap-ui-show-many-windows)
  (define-key xah-fly-shared-map (kbd "C-. d t") #'dap-breakpoint-toggle)
  (xah-fly-keys-set-layout "qwerty")
  (xah-fly-keys 1))

;; Note: https://github.com/xahlee/xah-fly-keys/commit/e58707a0edbfcf38d1ee2db73c961c8572ccd4a5
(defun xah-select-text-in-quote ()
  "Select text between the nearest left and right delimiters.
Delimiters here includes the following chars: '\"`<>(){}[]“”‘’‹›«»「」『』【】〖〗《》〈〉〔〕（）
This command select between any bracket chars, not the inner text of a bracket. For example, if text is
 (a(b)c▮)
 the selected char is “c”, not “a(b)c”.
URL `http://ergoemacs.org/emacs/modernization_mark-word.html'
Version 2020-03-11"
  (interactive)
  (let (
        ($skipChars "^'\"`<>(){}[]“”‘’‹›«»「」『』【】〖〗《》〈〉〔〕（）〘〙")
        $p1
        )
    (skip-chars-backward $skipChars)
    (setq $p1 (point))
    (skip-chars-forward $skipChars)
    (set-mark $p1)))

(after! web-mode
  (when (modulep! :editor fold)
    (define-key web-mode-map (kbd "C-c C-e C-f") 'web-mode-fold-or-unfold))
  (when (modulep! :lang web +tty)
    (setq web-mode-enable-auto-closing t
          web-mode-enable-auto-pairing t))
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-script-padding 2)
  (setq web-mode-style-padding 2)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-css-colorization t))

(after! css-mode
  (setq css-indent-offset 2))

(after! js2-mode
  (setq js2-basic-offset 2))

(after! typescript-mode
  (setq typescript-indent-level 2))

(when (modulep! :lang javascript)
  (def-project-mode! +web-vue-mode
    :modes '(+javascript-npm-mode)
    :when (+javascript-npm-dep-p '(or vue quasar))))

(use-package! pug-mode
  :mode "\\.tag\\'"
  :config
  (setq pug-tab-width 2))

(use-package! elm-mode
  :when (modulep! :lang elm)
  :config
  (setq elm-indent-offset 2))

(use-package! prettier-js
  :when (modulep! :editor format +prettier-deprecated)
  :defer t
  :hook ((web-mode css-mode json-mode js2-mode typescript-mode vue-mode) . prettier-js-mode)
  :config
  (setq prettier-js-show-errors "echo")
  (setq prettier-js-args
        '("--trailing-comma" "es5"
          "--single-quote" "true"
          "--arrow-parens" "always")))

(defun define-js-doc-keys (m)
  (define-key m "\C-cdd" 'jsdoc)
  (define-key m "\C-cdf" 'js-doc-insert-function-doc))
(add-hook 'web-mode-hook #'(lambda () (define-js-doc-keys web-mode-map)))
(add-hook 'js2-mode-hook #'(lambda () (define-js-doc-keys js2-mode-map)))
(add-hook 'rjsx-mode-hook #'(lambda () (define-js-doc-keys rjsx-mode-map)))
(add-hook 'typescript-mode-hook #'(lambda () (define-js-doc-keys typescript-mode-map)))
(add-hook 'typescript-tsx-mode-hook #'(lambda () (define-js-doc-keys typescript-tsx-mode-map)))

(after! restclient
  (require 'restclient-jq))

(use-package! dap-mode
  :when (and (modulep! :tools debugger +lsp) (modulep! :lang rust +lsp))
  :config
  (let (($path "~/.vscode/extensions/ms-vscode.cpptools-1.1.1"))
    (require 'dap-utils)
    (setq dap-cpptools-debug-path (expand-file-name "github/cpptools" dap-utils-extension-path))
    (setq dap-cpptools-debug-program
          `(,(concat (if (file-exists-p $path) $path
                       dap-cpptools-debug-path)
                     (if (file-exists-p $path) ""
                       "/extension")
                     (if (eq system-type 'windows-nt) "/debugAdapters/bin/OpenDebugAD7.exe"
                       "/debugAdapters/OpenDebugAD7"))))
    (setq dap-cpptools-download-url "https://github.com/microsoft/vscode-cpptools/releases/download/1.1.1/cpptools-osx.vsix")
    (defun dap-cpptools-setup (&optional forced)
      (interactive "P")
      (unless (and (not forced) (file-exists-p dap-cpptools-debug-path))
        (dap-utils--get-extension dap-cpptools-download-url dap-cpptools-debug-path)
        (let* ((adapter-binary (cl-first dap-cpptools-debug-program))
               (mono (f-join (f-parent adapter-binary) "mono.osx"))
               (lldb (f-join (f-parent adapter-binary) "lldb-mi/bin/lldb-mi")))
          (mapc
           (lambda (x) (when (f-exists? x) (set-file-modes x #o0755)))
           (list adapter-binary mono lldb)))
        (message "%s: Downloading done!" "dap-cpptools")))
    (defun dap-cpptools--populate-args (conf)
      (-> conf
          (dap--put-if-absent :dap-server-path dap-cpptools-debug-program)
          (dap--put-if-absent :request "launch")
          (dap--put-if-absent :type "cppdbg")
          (dap--put-if-absent :environment [])))
    (dap-register-debug-provider "cppdbg" #'dap-cpptools--populate-args)
    (dap-register-debug-template
     "cpptools::Run Configuration"
     (list :type "cppdbg"
           :request "launch"
           :name "cpptools::Run Configuration"
           :MIMode "lldb"
           :program "${workspaceFolder}/ replace with your binary"
           :cwd "${workspaceFolder}"))))

;; (after! youdao-dictionary
;;   (setq url-automatic-caching t)
;;   (setq youdao-dictionary-search-history-file "~/.youdao"))

(after! racer
  (setq racer-rust-src-path
        (let* ((sysroot (string-trim (shell-command-to-string "rustc --print sysroot")))
               (lib-path (concat sysroot "/lib/rustlib/src/rust/library"))
               (src-path (concat sysroot "/lib/rustlib/src/rust/src")))
          (or (when (file-exists-p lib-path) lib-path)
              (when (file-exists-p src-path) src-path)))))
