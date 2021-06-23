(use-package js2-mode
  :ensure t
  :init
  (setq js-basic-indent 2)
  (setq-default js2-basic-indent 2
                js2-basic-offset 2
                js2-auto-indent-p t
                js2-cleanup-whitespace t
                js2-enter-indents-newline t
                js2-indent-on-enter-key t
                js2-global-externs (list "window" "module" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON" "jQuery" "$"))

  (add-hook 'js2-mode-hook
            (lambda ()
              (push '("function" . ?ƒ) prettify-symbols-alist)))

  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))

(use-package color-identifiers-mode
    :ensure t
    :init
    (add-hook 'js2-mode-hook 'color-identifiers-mode))

(add-hook 'js2-mode-hook
          (lambda () (flycheck-select-checker "javascript-eslint")))

(use-package tern
   :ensure t
   :init (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
   :config
     (use-package company-tern
        :ensure t
        :init (add-to-list 'company-backends 'company-tern)))

(use-package js2-refactor
  :ensure t
  :init   (add-hook 'js2-mode-hook 'js2-refactor-mode)
  :config (js2r-add-keybindings-with-prefix "C-c ."))

(use-package skewer-mode
   :ensure t
   :init (add-hook 'js2-mode-hook 'skewer-mode))

(use-package coffee-mode
   :ensure t
   :init
   (setq-default coffee-tab-width 2))

(use-package ob-coffee
   :ensure t)

(provide 'init-javascript)

;;; js ends here
