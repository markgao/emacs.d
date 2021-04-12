;;; init-vue.el --- Support for Javascript and derivatives -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'vue-mode)
(maybe-require-package 'vue-html-mode)

;; Disabled the ugly background color

(add-hook 'mmm-mode-hook
          (lambda ()
            (set-face-background 'mmm-default-submode-face nil)))


(provide 'init-vue)
;;; init-javascript.el ends here
