;;; init-golang.el --- Python editing -*- lexical-binding: t -*-
;;; Commentary
;;; Code:

(when (maybe-require-package 'go-mode)
  (autoload 'go-mode "go-mode" nil t)
  (require-package 'go-eldoc)
  (require-package 'gotest)

  (defun mygo-mode-hook ()
    ;; eldoc shows the signature of the function at point in the status bar.
    (local-set-key (kbd "M-.") #'godef-jump)
    (add-hook 'before-save-hook 'gofmt-before-save)
    (go-eldoc-setup)
    ;; extra keybindings from https://github.com/bbatsov/prelude/blob/master/modules/prelude-go.el
    (let ((map go-mode-map))
      (define-key map (kbd "C-c a") 'go-test-current-project)
      (define-key map (kbd "C-c m") 'go-test-current-file)
      (define-key map (kbd "C-c .") 'go-test-current-test)
      (define-key map (kbd "C-c n") 'go-test-current-file-benchmarks)
      (define-key map (kbd "C-c ,") 'go-test-current-benchmark)
      (define-key map (kbd "C-c b") 'go-run)
      (define-key map (kbd "C-c C-r") 'go-remove-unused-imports)
      (define-key map (kbd "C-c i") 'go-goto-imports)
      )
    )

  (with-eval-after-load 'go-mode
    (setq-default tab-width 4)
    (add-hook 'go-mode-hook 'mygo-mode-hook)
    ;; (add-hook 'go-mode-hook (lambda ()
    ;;                           (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
    ;; (add-hook 'go-mode-hook (lambda ()
    ;;                           (local-set-key (kbd "C-c i") 'go-goto-imports)))
    ;; set GOBINPATH to PATH first when using gocode
    (when (maybe-require-package 'auto-complete)
      (auto-complete-mode 1)
      (with-eval-after-load 'auto-complete
        (require 'go-autocomplete)
        (require 'auto-complete-config)
        (ac-config-default)))
    ;; (when (maybe-require-package 'lsp-mode)
    ;;   (maybe-require-package 'lsp-ui)
    ;;   (use-package lsp-mode
    ;;     :ensure t
    ;;     :commands (lsp lsp-deferred)
    ;;     :hook (go-mode . lsp-deferred))
    ;;   ;; Set up before-save hooks to format buffer and add/delete imports.
    ;;   ;; Make sure you don't have other gofmt/goimports hooks enabled.
    ;;   (defun lsp-go-install-save-hooks ()
    ;;     (add-hook 'before-save-hook #'lsp-format-buffer t t)
    ;;     (add-hook 'before-save-hook #'lsp-organize-imports t t))
    ;;   (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
    ;;   ;; Optional - provides fancier overlays.
    ;;   (use-package lsp-ui
    ;;     :ensure t
    ;;     :commands lsp-ui-mode)
    ;;   ;; Company mode is a standard completion package that works well with lsp-mode.
    ;;   (use-package company
    ;;     :ensure t
    ;;     :config
    ;;     ;; Optionally enable completion-as-you-type behavior.
    ;;     (setq company-idle-delay 0)
    ;;     (setq company-minimum-prefix-length 1))
    ;;   ;; (add-hook 'go-mode-hook #'lsp-deferred)
    ;;   ;; ;; Set up before-save hooks to format buffer and add/delete imports.
    ;;   ;; ;; Make sure you don't have other gofmt/goimports hooks enabled.
    ;;   ;; (defun lsp-go-install-save-hooks ()
    ;;   ;;   (add-hook 'before-save-hook #'lsp-format-buffer t t)
    ;;   ;;   (add-hook 'before-save-hook #'lsp-organize-imports t t))
    ;;   ;; (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
    ;;   )
    )
  )

(provide 'init-golang)
;;; init-golang.el ends here
