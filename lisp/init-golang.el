;;; init-golang.el --- Python editing -*- lexical-binding: t -*-
;;; Commentary
;;; Code:

(when (maybe-require-package 'go-mode)
  (autoload 'go-mode "go-mode" nil t)
  (require-package 'gotest)
  (require-package 'company-go)
  ;; (require-package 'go-errcheck)

  (defun mygo-mode-hook ()
    ;; eldoc shows the signature of the function at point in the status bar.
    (local-set-key (kbd "M-.") 'godef-jump)
    (add-hook 'before-save-hook 'gofmt-before-save)
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
    (add-hook 'go-mode-hook (lambda ()
                              (set (make-local-variable 'company-backends) '(company-go))
                              (company-mode)))
    ;; (add-hook 'go-mode-hook (lambda ()
    ;;                           (local-set-key (kbd "C-c e") 'go-errcheck)))
    (with-eval-after-load 'company-go
      (setq company-tooltip-limit 10)   ; bigger popup window
      (setq company-show-numbers t)
      (setq company-minimum-prefix-length 2)
      (setq company-dabbrev-downcase nil)
      (setq company-dabbrev-other-buffers t)
      (setq company-auto-complete nil)
      (setq company-dabbrev-code-other-buffers 'all)
      (setq company-dabbrev-code-everywhere t)
      (setq company-dabbrev-code-ignore-case t)
      (setq company-idle-delay 0.800) ; decrease delay before autocompletion popup shows
      (setq company-echo-delay 0.500)  ; remove annoying blinking
      (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
      )
    ;; (when (maybe-require-package 'auto-complete)
    ;;   (auto-complete-mode 1)
    ;;   (with-eval-after-load 'auto-complete
    ;;     (require 'go-autocomplete)
    ;;     (require 'auto-complete-config)
    ;;     (ac-config-default)))
    )
  )


(provide 'init-golang)
;;; init-golang.el ends here
