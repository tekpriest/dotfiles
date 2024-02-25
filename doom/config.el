;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Michael Enitan"
      user-mail-address "asajuenitan@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'kanagawa)

(set-frame-parameter (selected-frame) 'alpha 85)
(add-to-list 'default-frame-alist '(alpha 80 80))
(add-hook! 'dired-mode-hook 'all-the-icons-dired-mode)
(add-hook! 'dired-mode-hook 'garbage-collect)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Code/notes/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq confirm-kill-emacs nil)

(defun arrayify (start end quote)
  "Turn strings on newlines into a QUOTEd, comma-separated one-liner."
  (interactive "r\nMQuote: ")
  (let ((insertion
         (mapconcat
          (lambda(x) (format "%s%s%s" quote x quote))
          (split-string (buffer-substring start end)), ", ")))
    (delete-region start end)
    (insert insertion)))

(projectile-add-known-project "~/Code/juice/juice-backend")
(projectile-add-known-project "~/Code/furex/backend")

(setq gc-cons-threshold 134217738
      gc-cons-percentage 0.1
      make-backup-files nil
      auto-save-default nil
      create-lockfiles nil
      vc-follow-symlinks t
      native-comp-async-report-warnings-errors nil
      load-prefer-newer t)
(set-language-environment "UTF-8")
(set-locale-environment "en_US.UTF-8")
(set-selection-coding-system 'utf-8-unix)
(set-charset-priority 'unicode)
(prefer-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(global-set-key (kbd "C-<wheel-up>") 'text-scale-increase)
(global-set-key (kbd "C-<wheel-down>") 'text-scale-decrease)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(delete-selection-mode t)
(setq scroll-conservatively 101
      mouse-wheel-scroll-amount '(2 ((shift) . 2))
      mouse-wheel-progressive-speed t
      mouse-wheel-follow-mouse 't
      scroll-step 1
      scroll-margin 2
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01
      hscroll-step 1
      hscroll-margin 1)
(setq evil-vsplit-window-right t
      evil-split-window-below t)
(add-hook! 'minibuffer-setup-hook 'garbage-collect)
(add-hook! '+popup-mode-hook (hide-mode-line-mode 1))
(add-hook! '+popup-mode-hook 'garbage-collect)
(setq which-key-idle-delay 0.2
      which-key-idle-secondary-delay 0.05
      +doom-dashboard--width 95
      +doom-dashboard-banner-padding '(0 . 0))
(add-hook! 'doom-switch-buffer-hook 'garbage-collect)
(setq-default ls-lisp-format-time-list '("%m/%d/%Y %I:%M:%S" "%m/%d/%Y %I:%M:%S"))
(setq ls-lisp-use-localized-time-format t
      display-time-format "%I:%M"
      display-time-default-load-average nil
      confirm-kill-processes nil
      tab-width 2
      indent-tabs-mode t
      indent-line-function 'insert-tab
      require-final-newline t
      next-line-add-newlines nil
      inhibit-startup-message t
      initial-scratch-message nil
      large-file-warning-threshold nil)
(setq warning-minimum-level :emergency)
;;
(after! doom-theme
	(setq doom-themes-enable-bold t
	      doom-themes-enable-italic t)
	(doom-themees-org-config)
	(doom-themes-visual-bell-config))
;;
(custom-set-faces!
	'(font-lock-comment-face :slant italic)
	'(font-lock-keyword-face :slant italic))
(add-hook! 'doom-dashboard-mode-hook 'garbage-collect)
(add-hook! 'doom-dashboard-mode-hook (hide-mode-line-mode 1))
(add-hook! 'doom-load-theme-hook 'garbage-collect)
(add-hook! 'doom-first-file-hook 'garbage-collect)
(add-hook! 'kill-emacs-hook 'garbage-collect)
(add-hook! 'after-init-hook 'garbage-collect)
(add-hook! 'doom-init-ui-hook 'garbage-collect)
(add-hook! 'doom-after-init-modules-hook 'garbage-collect)
(add-hook! 'eww-mode-hook 'garbage-collect)

(map!
 :m "C-h" #'evil-window-left
 :m "C-j" #'evil-window-down
 :m "C-k" #'evil-window-up
 :m "C-l" #'evil-window-right
 )

;; magit
(after! magit
  (custom-set-faces!
    '(magit-log-author :foreground "#d04b4e")
    '(magit-log-date :foreground "#f28735")
    '(magit-hash :foreground "#25c192")
    '(magit-filename :foreground "#49a6d0")
    '(magit-branch-current :foreground "#f74e8b"))
  (add-hook! 'magit-status-mode-hook (hide-mode-line-mode 1))
  (add-hook! 'magit-log-mode-hook (hide-mode-line-mode 1))
  (add-hook! 'magit-mode-hook 'garbage-collect)
  (add-hook! 'magit-log-mode-hook 'garbage-collect)
  (add-hook! 'magit-status-mode-hook 'garbage-collect)
  (add-hook! 'magit-popup-mode-hook 'garbage-collect))

(after! diff-hl
  (global-diff-hl-mode)
  (diff-hl-margin-mode)
  (diff-hl-flydiff-mode)
  (diff-hl-dired-mode)
  (diff-hl-show-hunk-mouse-mode))

(add-hook! 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
(add-hook! 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

(after! modeline
  (setq doom-modeline-buffer-file-name-style 'relative-to-project
        doom-modeline-icon (display-graphic-p)
        doom-modeline-major-mode-icon t
        doom-modeline-major-mode-color-icon t
        doom-modeline-env-version t
        doom-modeline-persp-icon t
        doom-modeline-unicode-fallback nil
        doom-modeline-buffer-state-icon nil
        doom-modeline-height 30
        doom-modeline-hud t
        doom-modeline-indent-info t
        doom-modeline-buffer-modification-icon nil)
  (add-hook! 'doom-modeline-mode-hook 'garbage-collect))
(setq-default doom-modeline-major-mode-icon t
              doom-modeline-major-mode-color-icon t
              doom-modeline-buffer-file-name-style 'relative-to-project
              doom-modeline-env-version t
              doom-modeline-persp-icon t
              doom-modeline-buffer-state-icon nil
              doom-modeline-unicode-fallback nil
              doom-modeline-hud t
              doom-modeline-height 30
              doom-modeline-indent-info t
              doom-modeline-buffer-modification-icon nil)

(after! org
  (add-hook! 'org-mode-hook 'garbage-collect)
  (add-hook! 'org-mode-hook #'org-modern-mode)
  (add-hook! 'org-agenda-finalize-hook #'org-modern-agenda)
  (add-hook! 'org-mode-hook 'org-fancy-priorities-mode)
  (setq org-directory "~/Code/notes"
        org-agenda-files '("~/Code/notes/todo.org" "~/Code/notes/agenda.org")
        org-agenda-block-separator 8411
        org-tags-column 0
        org-pretty-entities t
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-superstar-headline-bullets-list '("◉" "● " "○ " "◆" "●" "○" "◆")
        org-superstar-item-bullet-alist '((?+ . ?➤) (?- . ?✦))
        org-ellipsis "  "
        org-fold-catch-invisible-edits 'smart
        org-log-done 'time
        org-journal-dir "~/Code/notes/journal/"
        org-hide-emphasis-markers t
        org-support-shift-select t
        org-src-preserve-indentation nil
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 0)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "VIDEO(v)" "IDEA(i)" "DONE(d)" "EVENT(e)"))
        org-todo-keyword-faces
        '(("TODO" . 'all-the-icons-red)
          ("NEXT" . 'all-the-icons-blue)
          ("VIDEO" . 'all-the-icons-yellow)
          ("IDEA" . 'all-the-icons-green)
          ("DONE" . 'all-the-icons-orange)
          ("EVENT" . 'all-the-icons-cyan)))
  (custom-set-faces!
    '(org-agenda-calendar-event :inherit variable-pitch)
    '(org-agenda-calendar-sexp :inherit variable-pitch)
    '(org-agenda-filter-category :inherit variable-pitch)
    '(org-agenda-filter-tags :inherit variable-pitch)
    '(org-agenda-date :inherit variable-pitch :weight bold :height 1.09)
    '(org-agenda-date-weekend :inherit variable-pitch :weight bold :height 1.06)
    '(org-agenda-done :inherit variable-pitch :weight bold)
    '(org-agenda-date-today :inherit variable-pitch :weight bold :slant italic :height 1.12)
    '(org-agenda-date-weekend-today :inherit variable-pitch :weight bold :height 1.09)
    '(org-agenda-dimmed-todo-face :inherit variable-pitch :weight bold)
    '(org-agenda-current-time :inherit variable-pitch :weight bold)
    '(org-agenda-clocking :inherit variable-pitch :weight bold))
  (add-hook! 'org-agenda-mode-hook 'mixed-pitch-mode)
  (add-hook! 'org-agenda-mode-hook (hide-mode-line-mode 1))
  (custom-set-faces!
    '(org-document-title :height 1.3)
    '(org-level-1 :inherit outline-1 :weight extra-bold :height 1.35)
    '(org-level-2 :inherit outline-2 :weight bold :height 1.15)
    '(org-level-3 :inherit outline-3 :weight bold :height 1.12)
    '(org-level-4 :inherit outline-4 :weight bold :height 1.09)
    '(org-level-5 :inherit outline-5 :weight bold :height 1.06)
    '(org-level-6 :inherit outline-6 :weight semi-bold :height 1.03)
    '(org-level-7 :inherit outline-7 :weight semi-bold)
    '(org-level-8 :inherit outline-8 :weight semi-bold)))
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
(after! treemacs
    (setq doom-themes-treemacs-theme "doom-colors")
    (setq doom-themes-treemacs-enable-variable-pitch t))
