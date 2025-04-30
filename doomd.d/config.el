;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq default-frame-alist '((undecorated . t)))

(setq
 user-full-name "Michael Enitan"
 user-mail-address "asajuenitan@gmail.com"
 doom-font (font-spec :family "Dank Mono" :size 9)
 display-line-numbers-type 'relative
 load-prefer-newer t
 +zen-text-scale 1
 org-directory "~/Code/notes"
 org-ellipsis " ▼ "
 org-adapt-indentation nil
 org-habit-show-habits-only-for-today t
 doom-themes-enable-bold t
 doom-themes-enable-italic t
 confirm-kill-emacs nil
 native-comp-async-report-warnings-errors nil
 )

;; mac
;; (mac-command-key-is-meta t)

;; theme
(doom-themes-treemacs-config)
(add-hook 'server-after-make-frame-hook #'catppuccin-reload)
(setq
 catppuccin-flavor 'mocha
 doom-theme 'catppuccin
 )

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(set-frame-parameter nil 'alpha-background 70)
(add-to-list 'default-frame-alist '(alpha-background . 70))

(setq-default c-basic-offset 4
              c-default-style "linux"
              indent-tabs-mode nil
              fill-column 100
              tab-width 2)

;; evil settings
(after! evil
  (setq
   evil-move-cursor-back nil
   evil-shift-width 2
   evil-split-window-below t
   evil-vsplit-window-right t
   evil-echo-state nil
   evil-mode-line-format nil
   )
  )
(evil-define-key 'visual 'global
  "gc" 'comment-line
  "Q" nil
  "q" nil
  )
(evil-define-key 'normal 'global
  "Q" nil
  "q" nil
  )
(evil-define-key 'normal 'global
  (kbd "SPC wk") 'evil-window-up
  (kbd "SPC wj") 'evil-window-down
  (kbd "SPC wl") 'evil-window-right
  (kbd "SPC wh") 'evil-window-left
  )
(remove-hook 'doom-first-input-hook #'evil-snipe-mode)
(with-eval-after-load 'evil
  (general-add-hook 'after-init-hook
                    (lambda (&rest _)
                      (when-let ((messages-buffer (get-buffer "*Messages")))
                        (with-current-buffer messages-buffer
                          (evil-normalize-keymaps))))
                    nil
                    nil
                    t))

(setq projectile-project-search-path '("~/Code/personal" "~/Code/juice" "~/Code/furex"))

(use-package! git-link
  :commands
  (git-link git-link-commit git-link-homepage)
  :custom
  (git-link-use-commit t))

(after! go-mode
  (after! flycheck
    (setq flycheck-go-build-tags '("dynamic"))))

;; for move-text
(move-text-default-bindings)
(after! move-text
  (evil-define-key 'normal 'global
    (kbd "M-k") 'move-text-up
    (kbd "M-j") 'move-text-down))

(defun indent-region-advice (&rest _)
  (let ((deactivate deactivate-mark))
    (if (region-active-p)
        (indent-region (region-beginning) (region-end))
      (indent-region (line-beginning-position) (line-end-position)))
    (setq deactivate-mark deactivate)))

(advice-add 'move-text-up :after 'indent-region-advice)
(advice-add 'move-text-down :after 'indent-region-advice)

(setq world-clock-list
      '(("Africa/Lagos" "Lagos")))

(use-package! forge :after magit)
(use-package! lsp-tailwindcss)
(use-package! prisma-mode)
(use-package solaire-mode
  :ensure t
  :hook (after-init . solaire-global-mode))

(use-package elixir-mode
 :hook (elixir-mode . (lambda ()
    (push '(">=" . ?\u2265) prettify-symbols-alist)
    (push '("<=" . ?\u2264) prettify-symbols-alist)
    (push '("!=" . ?\u2260) prettify-symbols-alist)
    (push '("==" . ?\u2A75) prettify-symbols-alist)
    (push '("=~" . ?\u2245) prettify-symbols-alist)
    (push '("<-" . ?\u2190) prettify-symbols-alist)
    (push '("->" . ?\u2192) prettify-symbols-alist)
    (push '("<-" . ?\u2190) prettify-symbols-alist)
    (push '("|>" . ?\u25B7) prettify-symbols-alist))))
