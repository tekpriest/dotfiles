(require 'package)

;;; Code

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

;; Keep installed packages in .config/emacs
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))

(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
                         ("gnu"       . "http://elpa.gnu.org/packages/")
                         ("melpa"     . "http://melpa.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

(package-initialize)
;; update the package metadata if the local cache is missing
(unless package-archive-contents
  (package-refresh-contents))

(setq user-full-name "Asaju Enitan"
      user-mail-address "mikkysam52@gmail.com")

;; always load newest byte code
(setq load-prefer-newer t)

;; reduce the frequency of garbase collection by making it happen on
;; each 50MB of allocated data
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

(defconst en1tan-savefile-dir (expand-file-name "savefile" user-emacs-directory))

;; create the savefile dir if it doesn't exist
(unless (file-exists-p en1tan-savefile-dir)
  (make-directory en1tan-savefile-dir))

;; hide toolbar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(defun x1k/highlite-logs ()
  "Highlight certain lines in specific files.  Currently, only log files are supported."
  (interactive)
  (when (equal "log" (file-name-extension (buffer-file-name)))
        (hi-lock-mode 1)
        (highlight-lines-matching-regexp "ERROR:" 'hi-red-b)
        (highlight-lines-matching-regexp "NOTE:" 'hi-blue-b)))

(add-hook 'find-file-hook 'x1k/highlite-logs)

;; hide menu bar
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))

(require 'js)

;; We go EVIL
(unless (package-installed-p 'evil)
  (package-install 'evil))

(require 'evil)
(evil-mode 1)

(use-package find-dired
  :ensure t
  :init (setq find-ls-option '("-print0 | xargs -0 ls -od" . "-od")))

(use-package peep-dired
  :defer t ; don't access `dired-mode-map' until `peep-dired' is loaded
  :bind (:map dired-mode-map
              ("P" . peep-dired))
  )

(use-package dired-x)

(use-package ido
  :ensure t
  :init  (setq ido-enable-flex-matching t
               ido-ignore-extensions t
               ido-use-virtual-buffers t
               ido-everywhere t)
  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (add-to-list 'completion-ignored-extensions ".pyc"))

(use-package ido-vertical-mode
  :ensure t
  :init               ; I like up and down arrow keys:
  (setq ido-vertical-define-keys 'C-n-C-p-up-and-down)
  :config
  (ido-vertical-mode 1))

(use-package ag
  :ensure t
  :commands ag
  :init   (setq ag-highlight-search t)
  :config (add-to-list 'ag-arguments "--word-regexp"))

;; I find the blinking cursor annoying
(blink-cursor-mode -1)

;; disable the bell
(setq ring-bell-function 'ignore)


;; disable startup screen
(setq inhibit-startup-screen t)
;; smooth scrolling...kinda
(setq scroll-margin 0
      scroll-conservatively 1000000
      scroll-preserve-screen-position 1)

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; enable y/n answersss
(fset 'yes-or-no-p 'y-or-n-p)

(use-package smex
  :ensure t
  :init (smex-initialize)
  :bind ("M-x" . smex)
        ("M-x" . smex-major-mode-commands))

;; maximize the initial frame automatically
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't an external file)
(setq frame-title-format
      '((:eval (if (buffer-file-name)
		   (abbreviate-file-name (buffer-file-name))
		 "%b"))))

(setq-default indent-tabs-mode nil) ;; don't use tabs to indent
(setq-default tab-width 2) ;; but maintain corrent appearance

;; newline at end of file
(setq require-final-newline t)

;; wrap lines at 80 characters
(setq-default fill-column 80)

;; delete the selection with a keypress
(delete-selection-mode t)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; revert buffers automatically if changed externally
(global-auto-revert-mode t)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; set hippie expand if dabbrev expand is on steroids
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-from-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))

;; use hippie-expand instead of dabbrev
(global-set-key (kbd "M-/") #'hippie-expand)
(global-set-key (kbd "s-/") #'hippie-expand)

;; replace buffer-menu with buffer
(global-set-key (kbd "C-x C-b") #'ibuffer)

;; align code in a pretty way
(global-set-key (kbd "C-x \\") #'align-regexp)

;; display info manual
(define-key 'help-command (kbd "C-i") #'info-display-manual)

;; useful keybindings
(global-set-key (kbd "s-<") #'beginning-of-buffer)
(global-set-key (kbd "s->") #'end-of-buffer)
(global-set-key (kbd "s-q") #'fill-paragraph)
(global-set-key (kbd "s-x") #'execute-extended-command)

;; smart tab behavior - indent or complete
(setq tab-always-indent 'compelete)


(use-package workgroups
  :ensure t
  :diminish workgroups-mode
  :config
  (setq wg-prefix-key (kbd "C-c a"))
  (workgroups-mode 1)
  (wg-load "~/.emacs.d/workgroups"))

;; enable some commands that are disabled by default
;; (put 'erase-buffer 'disabled nil)
(setq initial-scratch-message "")
(setq visible-bell t)

(setq vc-make-backup-files t)

(defun save-all ()
  "Save all dirty buffers without asking for confimation."
  (interactive)
  (save-some-buffers t))

(add-hook 'focus-out-hook 'save-all)

(when (window-system)
  (when (fboundp 'horizontal-scroll-bar-mode)
    (horizontal-scroll-bar-mode -1))
  (scroll-bar-mode -1))

(set-face-background 'region "blue3")

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)

;; built-in packages
(use-package paren
  :config
  (show-paren-mode +1))

;; enhancements
(require 'cl)

(use-package dash
  :ensure t
  :config (eval-after-load "dash" '(global-dash-fontify-mode)))

(use-package s
  :ensure t)

(use-package f
  :ensure t)

(use-package elec-pair
  :config
  (electric-pair-mode +1))

(use-package calendar
  :config
  ;; weeks in Nigeria start on Sunday
  (setq calendar-week-start-day 0))


(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn))

;; hightlight the current line
(use-package hl-line
  :config
  (global-hl-line-mode +1))

(use-package abbrev
  :config
  (setq save-abbrevs 'silently)
  (setq-default abbrev-mode t))

(defun narrow-or-widen-dwim (p)
  "If the buffer is narrowed, it widens.  Otherwise, it narrows intelligently.
Intelligently means: region, subtree, or defun, whichever applies
first.

With prefix P, don't widen, just narrow even if buffer is already
narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning) (region-end)))
        ((derived-mode-p 'org-mode) (org-narrow-to-subtree))
        (t (narrow-to-defun))))

(global-set-key (kbd "C-x n x") 'narrow-or-widen-dwim)

(use-package fancy-narrow
  :ensure t
  :config
  (defun ha/highlight-block ()
    "Highlights a 'block' in a buffer defined by the first blank
     line before and after the current cursor position. Uses the
     'fancy-narrow' mode to high-light the block."
    (interactive)
    (let (cur beg end)
      (setq cur (point))
      (setq end (or (re-search-forward  "^\s*$" nil t) (point-max)))
      (goto-char cur)
      (setq beg (or (re-search-backward "^\s*$" nil t) (point-min)))
      (fancy-narrow-to-region beg end)
      (goto-char cur)))

  (defun ha/highlight-section (num)
    "If some of the buffer is highlighted with the `fancy-narrow'
     mode, then un-highlight it by calling `fancy-widen'.

     If region is active, call `fancy-narrow-to-region'.

     If NUM is 0, highlight the current block (delimited by blank
     lines). If NUM is positive or negative, highlight that number
     of lines.  Otherwise, called `fancy-narrow-to-defun', to
     highlight current function."
    (interactive "p")
    (cond
     ((fancy-narrow-active-p)  (fancy-widen))
     ((region-active-p)        (fancy-narrow-to-region (region-beginning) (region-end)))
     ((= num 0)                (ha/highlight-block))
     ((= num 1)                (fancy-narrow-to-defun))
     (t                        (progn (ha/expand-region num)
                                      (fancy-narrow-to-region (region-beginning) (region-end))
                                      (setq mark-active nil)))))

  :bind (("C-M-+" . ha/highlight-section)
         ("C-<f12>" . ha/highlight-section)))

(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-separator "/")
  ;;rename after killing uniquified
  (setq uniquify-after-kill-buffer-p t)
  ;; don't muck with special buffers
  (setq uniquify-ignore-buffers-re "^\\*"))

;; saveplace remembers your location in a file when saving files
(use-package saveplace
  :config
  (setq save-place-file (expand-file-name "saveplace" en1tan-savefile-dir))
  ;; activate it for all buffers
  (setq-default save-place t))

(use-package savehist
  :config
  (setq savehist-additional-variables
        ;; search entries
        '(search-ring regexp-search-ring)
        ;; save every minute
        savehist-autosave-interval 60
        ;;keep the home clean
        savehist-file (expand-file-name "savehist" en1tan-savefile-dir))
  (savehist-mode +1))

(use-package recentf
  :config
  (setq recentf-save-file (expand-file-name "recentf" en1tan-savefile-dir)
        recentf-max-saved-items 500
        recentf-max-menu-items 25
        ;; disable recentf-cleanup on Emacs start, because it can cause
        ;; problems with remote files
        recentf-auto-cleanup 'never
        recentf-keep '(file-remote-p file-readable-p))
  (recentf-mode 1)
  (let ((last-ido "~/.emacs.d/ido.last"))
    (when (file-exists-p last-ido)
      (delete-file last-ido)))
  :bind ("C-c f r" . recentf-open-files))

(use-package windmove
  :config
  ;; use shift + arrow keys to switch between visible buffers
  (windmove-default-keybindings))

(use-package dired
  :config
  ;; dired - reuse current buffer by pressing 'a'
  (put 'dired-find-alternate-file 'disabled nil)

  ;; always delete and copy recursively
  (setq dired-recursive-deletes 'always)
  (setq dired-recursive-copies 'always)

  ;; if there is a dired buffer displayed in the next window, use its
  ;; current subdir, instead of the current subdir of this dired buffer
  (setq dired-dwim-target t)

  ;; enable some really cool extensions like C-x C-j(dired-jump)
  (require 'dired-x))

(use-package lisp-mode
  :config
  (defun en1tan-visit-ielm ()
    "Switch to default `ielm' buffer.
Start `ielm' if it's not already running."
    (interactive)
    (crux-start-or-switch-to 'ielm "*ielm*"))

  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
  (define-key emacs-lisp-mode-map (kbd "C-c C-z") #'en1tan-visit-ielm)
  (define-key emacs-lisp-mode-map (kbd "C-c C-c") #'eval-defun)
  (define-key emacs-lisp-mode-map (kbd "C-c C-b") #'eval-buffer))

(use-package ielm
  :config
  (add-hook 'ielm-mode-hook #'rainbow-delimiters-mode))

;;; third-party packages
(use-package zenburn-theme
  :ensure t)

(use-package diminish
  :ensure t
  :config
  (diminish 'abbrev-mode)
  (diminish 'flyspell-mode)
  (diminish 'flyspell-prog-mode)
  (diminish 'eldoc-mode))

(use-package perspective
  :ensure t
  :bind ("C-x x x" . persp-switch-last)
  :init (persp-mode +1)

  (use-package persp-projectile
    :ensure t
    :bind ("C-x x P" . projectile-persp-switch-project))

  :config
    (setq persp-interactive-completion-function #'ido-completing-read)
    (persp-turn-off-modestring))

(use-package avy
  :ensure t
  :bind (("s-." . avy-goto-word-or-subword-1)
         ("s-," . avy-goto-char)
         ("C-c ." . avy-goto-word-or-subword-1)
         ("C-c ," . avy-goto-char)
         ("M-g f" . avy-goto-line)
         ("M-g w" . avy-goto-word-or-subword-1))
  :config
  (setq avy-background t))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package git-timemachine
  :ensure t
  :bind (("C-x C-g" . git-timemachine)))

(use-package ag
  :ensure t)

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :init (projectile-global-mode 1)
  :commands projectile-ag
  :config
  (setq projectile-switch-project-action 'projectile-commander
        projectile-completion-system 'ido
        projectile-create-missing-test-files t)
  (add-to-list 'projectile-globally-ignored-files ".DS_Store, node_modules")

  (def-projectile-commander-method ?d
    "Open project root in dired."
    (projectile-dired))

  (def-projectile-commander-method ?s
    "Open a *shell* buffer for the project."
    (projectile-run-shell))

  (def-projectile-commander-method ?X
    "Open a Direx buffer on the side."
    (call-interactively #'ha/projectile-direx))

  (def-projectile-commander-method ?F
    "Git fetch."
    (magit-status)
    (call-interactively #'magit-fetch-current))

  (def-projectile-commander-method ?j
    "Jack-in with Cider."
    (let* ((opts (projectile-current-project-files))
           (file (ido-completing-read
                  "Find file: "
                  opts
                  nil nil nil nil
                  (car (cl-member-if
                        (lambda (f)
                          (string-match "core\\.clj\\'" f))
                        opts)))))
      (find-file (expand-file-name
                  file (projectile-project-root)))
      (run-hooks 'projectile-find-file-hook)
      (cider-jack-in))))

(use-package direx
  :ensure t
  :bind (("C-c p X" . ha/projectile-direx)
         :map direx:direx-mode-map
         ("q" . kill-buffer-and-window))
  :init
  (defun kill-buffer-and-window (&optional buffer)
    "Kills the buffer and closes the window it is in."
    (interactive)
    (kill-buffer buffer)
    (delete-window))

  (defun ha/projectile-direx (prefix)
    "Start direx in the top-level of a project in a buffer window
     that spans the entire left side of the frame."
    (interactive "P")
    (let ((file-name (file-name-nondirectory (buffer-file-name)))
          (buffer (direx:find-directory-reuse-noselect (projectile-project-root)))
          (window (ha/split-main-window 'left 30)))
      (select-window window)
      (direx:maybe-goto-current-buffer-item buffer)
      (switch-to-buffer buffer)
      (search-forward file-name))))

(defun ha/split-main-window (direction size)
  "Split the main window in the DIRECTION where DIRECTION is a
symbol with possible values of 'right, 'left, 'above or 'below
and SIZE is the final size of the windows, if the window is split
horizontally (i.e. DIRECTION 'below or 'above) SIZE is assumed to
be the target height otherwise SIZE is assumed to be target width."
  (let* ((new-window (split-window (frame-root-window) nil direction))
         (horizontal (member direction '(right left))))
    (save-excursion
      (select-window new-window)
      (enlarge-window (- size (if horizontal
                                  (window-width)
                                (window-height)))
                      horizontal))
    new-window))

(use-package winner
  :ensure t
  :init (winner-mode 1))

(use-package pt
  :ensure t)

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))


(use-package elisp-slime-nav
  :ensure t
  :config
  (dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
    (add-hook hook #'elisp-slime-nav-mode))
  (diminish 'elisp-slime-nav-mode))

(use-package paredit
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook #'paredit-mode)
  ;; enable in the *scratch* buffer
  (add-hook 'lisp-interaction-mode-hook #'paredit-mode)
  (add-hook 'ielm-mode-hook #'paredit-mode)
  (add-hook 'lisp-mode-hook #'paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'paredit-mode)
  (diminish 'paredit-mode "()"))

(use-package anzu
  :ensure t
  :bind (("M-%" . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp))
  :config
  (global-anzu-mode))


(use-package easy-kill
  :ensure t
  :config
  (global-set-key [remap kill-ring-save] 'easy-kill))

(use-package move-text
  :ensure t
  :bind
  (([(meta shift up)] . move-text-up)
   ([(meta shift down)] . move-text-down)))

(use-package rainbow-delimiters
  :ensure t)

(use-package rainbow-mode
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-mode)
  (diminish 'rainbow-mode))

(use-package whitespace
  :init
  (dolist (hook '(prog-mode-hook text-mode-hook))
    (add-hook hook #'whitespace-mode))
  (add-hook 'before-save-hook #'whitespace-cleanup)
  :config
  (setq whitespace-line-column 80) ;; limit line length
  (setq whitespace-style '(face tabs empty trailing lines-tail)))

(use-package inf-ruby
  :ensure t
  :config
  (add-hook 'ruby-mode-hook #'inf-ruby-minor-mode))

(use-package ruby-mode
  :config
  (setq ruby-insert-encoding-magic-comment nil)
  (add-hook 'ruby-mode-hook #'subword-mode))

(use-package web-mode
  :ensure t
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2)
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode)))

(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'" . gfm-mode)
         ("\\.markdown\\'" . gfm-mode))
  :config
  (setq markdown-fontify-code-blocks-natively t)
  :preface
  (defun jekyll-insert-image-url ()
    (interactive)
    (let* ((files (directory-files "../assets/images"))
           (selected-file (completing-read "Select image: " files nil t)))
      (insert (format "![%s](/assets/images/%s)" selected-file selected-file))))

  (defun jekyll-insert-post-url ()
    (interactive)
    (let* ((files (remove "." (mapcar #'file-name-sans-extension (directory-files "."))))
           (selected-file (completing-read "Select article: " files nil t)))
      (insert (format "{%% post_url %s %%}" selected-file)))))

(use-package yaml-mode
  :ensure t)

(use-package selectrum
  :ensure t
  :config
  (selectrum-mode +1))

(use-package selectrum-prescient
  :ensure t
  :config
  (selectrum-prescient-mode +1)
  (prescient-persist-mode +1))

(use-package flyspell
  :ensure t
  :diminish flyspell-mode
  :init
  (add-hook 'prog-mode-hook 'flyspell-prog-mode)

  (dolist (hook '(text-mode-hook org-mode-hook))
    (add-hook hook (lambda () (flyspell-mode 1))))

  (dolist (hook '(change-log-mode-hook log-edit-mode-hook org-agenda-mode-hook))
    (add-hook hook (lambda () (flyspell-mode -1))))

  :config
  (setq ispell-program-name "/usr/bin/aspell"
        ispell-local-dictionary "en_US"
        ispell-dictionary "american" ; better for aspell
        ispell-extra-args '("--sug-mode=ultra" "--lang=en_US")
        ispell-list-command "--list"
        ispell-local-dictionary-alist '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "['‘’]"
                                      t ; Many other characters
                                      ("-d" "en_US") nil utf-8))))

(use-package company
  :ensure t
  :init
  (setq company-dabbrev-code-ignore-case t
        company-show-numbers t)
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (add-to-list 'company-backends 'company-math-symbols-unicode)
  :bind ("C-:" . company-complete)
  ;; invert the navigation direction if the the completion popup-isearch-match
  ;; is displayed on top (happens near the bottom of windows)
  (setq company-tooltip-flip-when-above t)
  (diminish 'company-mode))

(use-package hl-todo
  :ensure t
  :config
  (setq hl-todo-highlight-punctuation ":")
  (global-hl-todo-mode))

(use-package zop-to-char
  :ensure t
  :bind (("M-z" . zop-up-to-char)
         ("M-Z" . zop-to-char)))


(use-package imenu-anywhere
  :ensure t
  :bind (("C-c i" . imenu-anywhere)
         ("s-i" . imenu-anywhere)))

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package flycheck-eldev
  :ensure t)

(use-package super-save
  :ensure t
  :config
  ;; add integration with ace-window
  (add-to-list 'super-save-triggers 'ace-window)
  (super-save-mode +1)
  (diminish 'super-save-mode))

(use-package linum
  :init
  (add-hook 'prog-mode-hook 'linum-mode)
  (add-hook 'linum-mode-hook (lambda () (set-face-attribute 'linum nil :height 8)))

  :config
  (defun linum-fringe-toggle ()
    "Toggles the line numbers as well as the fringe."    (interactive)
    (cond (linum-mode (fringe-mode '(0 . 0))
                      (linum-mode -1))
          (t          (fringe-mode '(8 . 0))
                      (linum-mode 1))))

  :bind (("A-C-k"   . linum-mode)
         ("s-C-k"   . linum-mode)
         ("A-C-M-k" . linum-fringe-toggle)
         ("s-C-M-k" . linum-fringe-toggle)))

(use-package linum-relative
  :ensure t
  :config
  (defun linum-new-mode ()
    "If line numbers aren't displayed, then display them.
     Otherwise, toggle between absolute and relative numbers."
    (interactive)
    (if linum-mode
        (linum-relative-toggle)
      (linum-mode 1)))

  :bind ("A-k" . linum-new-mode)
  ("s-k" . linum-new-mode))   ;;For Linux

(use-package smartscan
  :ensure t
  :bind ("M-n" . smartscan-symbol-go-forward)
  ("M-p" . smartscan-symbol-go-backward))

(setq tags-add-tables nil)

(defun x1k/hs-show-all ()
  (interactive)
  (hs-minor-mode 1)
  (hs-show-all))

(defun x1k/hs-hide-all ()
  (interactive)
  (hs-minor-mode 1)
  (hs-hide-all))

(defun x1k/hs-toggle-hiding ()
  (interactive)
  (hs-minor-mode 1)
  (hs-toggle-hiding))

(use-package hs-minor-mode
  :bind
  ("C-c T h" . hs-minor-mode)
  ("C-c h a" . x1k/hs-hide-all)
  ("C-c h s" . x1k/hs-show-all)
  ("C-c h h" . x1k/hs-toggle-hiding))

(use-package idomenu
  :ensure t
  :bind ("C-c i" . idomenu))

(use-package helm
  :bind (("C-c M-i" . helm-imenu)))

(use-package ido
  :config
  (defun ido-find-tag ()
    "Find a tag using ido"
    (interactive)
    (tags-completion-table)
    (let (tag-names)
      (mapatoms (lambda (x)
                  (push (prin1-to-string x t) tag-names))
                tags-completion-table)
      (find-tag (ido-completing-read "Tag: " tag-names))))

  (global-set-key (kbd "C-c I") 'ido-find-tag))

(use-package etags
  :init (setq tags-revert-without-query 1))

(use-package crux
  :ensure t
  :bind (("C-c o" . crux-open-with)
         ("M-o" . crux-smart-open-line)
         ("C-c n" . crux-cleanup-buffer-or-region)
         ("C-c f" . crux-recentf-find-file)
         ("C-M-z" . crux-indent-defun)
         ("C-c u" . crux-view-url)
         ("C-c e" . crux-eval-and-replace)
         ("C-c w" . crux-swap-windows)
         ("C-c D" . crux-delete-file-and-buffer)
         ("C-c r" . crux-rename-buffer-and-file)
         ("C-c t" . crux-visit-term-buffer)
         ("C-c k" . crux-kill-other-buffers)
         ("C-c TAB" . crux-indent-rigidly-and-copy-to-clipboard)
         ("C-c I" . crux-find-user-init-file)
         ("C-c S" . crux-find-shell-init-file)
         ("s-r" . crux-recentf-find-file)
         ("s-j" . crux-top-join-line)
         ("C-^" . crux-top-join-line)
         ("s-k" . crux-kill-whole-line)
         ("C-<backspace>" . crux-kill-line-backwards)
         ("s-o" . crux-smart-open-line-above)
         ([remap move-beginning-of-line] . crux-move-beginning-of-line)
         ([(shift return)] . crux-smart-open-line)
         ([(control shift return)] . crux-smart-open-line-above)
         ([remap kill-whole-line] . crux-kill-whole-line)
         ("C-c s" . crux-ispell-word-then-abbrev)))



(use-package diff-hl
  :ensure t
  :config
  (global-diff-hl-mode +1)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(use-package which-key
  :ensure t
  :config
  (which-key-mode +1)
  (diminish 'which-key-mode))

(use-package winner
  :ensure t
  :init (winner-mode 1))

(use-package undo-tree
  :ensure t
  :config
  ;; autosave the undo-tree history
  (setq undo-tree-history-directory-alist
        `((".*" . ,temporary-file-directory)))
  (setq undo-tree-auto-save-history t)
  (global-undo-tree-mode +1)
  (diminish 'undo-tree-mode))

(use-package ace-window
  :ensure t
  :init
   (setq aw-keys '(?a ?s ?d ?f ?j ?k ?l ?o))
   (global-set-key (kbd "C-x o") 'ace-window)
  :diminish ace-window-mode)


  ( use-package vterm
  :ensure t
  :config
  (setq vterm-shell "/bin/zsh")
  ;; macOS
  (global-set-key (kbd "s-v") 'vterm)
  ;; Linux
  (global-set-key (kbd "C-c v") 'vterm))

;; super useful for demos
(use-package keycast
  :ensure t
  :config
  (global-set-key (kbd "C-x C-k") 'keycast-mode))

(use-package gif-screencast
  :ensure t
  :config
  ;; To shut up the shutter sound of `screencapture' (see `gif-screencast-command').
  (setq gif-screencast-args '("-x"))
  ;; Optional: Used to crop the capture to the Emacs frame.
  (setq gif-screencast-cropping-program "mogrify")
  ;; Optional: Required to crop captured images.
  (setq gif-screencast-capture-format "ppm"))

(use-package multiple-cursors
  :ensure t
  :bind (("C-c C-. ."   . mc/mark-all-dwim)
         ("C-c C-. C-." . mc/mark-all-like-this-dwim)
         ("C-c C-. n"   . mc/mark-next-like-this)
         ("C-c C-. C-n" . mc/mark-next-like-this)
         ("C-c C-. p"   . mc/mark-previous-like-this)
         ("C-c C-. C-p" . mc/mark-previous-like-this)
         ("C-c C-. a"   . mc/mark-all-like-this)
         ("C-c C-. C-a" . mc/mark-all-like-this)
         ("C-c C-. N"   . mc/mark-next-symbol-like-this)
         ("C-c C-. C-N" . mc/mark-next-symbol-like-this)
         ("C-c C-. P"   . mc/mark-previous-symbol-like-this)
         ("C-c C-. C-P" . mc/mark-previous-symbol-like-this)
         ("C-c C-. A"   . mc/mark-all-symbols-like-this)
         ("C-c C-. C-A" . mc/mark-all-symbols-like-this)
         ("C-c C-. f"   . mc/mark-all-like-this-in-defun)
         ("C-c C-. C-f" . mc/mark-all-like-this-in-defun)
         ("C-c C-. l"   . mc/edit-lines)
         ("C-c C-. C-l" . mc/edit-lines)
         ("C-c C-. e"   . mc/edit-ends-of-lines)
         ("C-c C-. C-e" . mc/edit-ends-of-lines)
         ("C-M-<mouse-1>" . mc/add-cursor-on-click)))

;; temporarily highlight changes from yanking, etc
(use-package volatile-highlights
  :ensure t
  :config
  (volatile-highlights-mode +1)
  (diminish 'volatile-highlights-mode))

(use-package expand-region
  :ensure t
  :config
  (defun ha/expand-region (lines)
    "Prefix-oriented wrapper around Magnar's `er/expand-region'.

Call with LINES equal to 1 (given no prefix), it expands the
region as normal.  When LINES given a positive number, selects
the current line and number of lines specified.  When LINES is a
negative number, selects the current line and the previous lines
specified.  Select the current line if the LINES prefix is zero."
    (interactive "p")
    (cond ((= lines 1)   (er/expand-region 1))
          ((< lines 0)   (ha/expand-previous-line-as-region lines))
          (t             (ha/expand-next-line-as-region (1+ lines)))))

  (defun ha/expand-next-line-as-region (lines)
    (message "lines = %d" lines)
    (beginning-of-line)
    (set-mark (point))
    (end-of-line lines))

  (defun ha/expand-previous-line-as-region (lines)
    (end-of-line)
    (set-mark (point))
    (beginning-of-line (1+ lines)))

  :bind ("C-=" . ha/expand-region))

(set-frame-font "FiraCode 7")

;; font ligatures
(defun lig-symbols (pretty-alist)
  ;; prepend a TAB charactr to each symbol in this alist
  ;; this way compose-region called by prettify-symbols-mode
  ;; will use the correct width of the symbols
  ;; instead of the width measured by char-width
  (mapcar (lambda (el)
            (setcdr el (string ?\t (cdr el)))
            el)
          pretty-alist))

(defun lig-list (ligatures codepoint-start)
    ;;; create an alist of strings to replace with
    (let ((codepoints (-iterate '1+ codepoint-start (length ligatures))))
    (-zip-pair ligatures codepoints)))

(setq fira-code-ligs
      (let* ((ligs '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\"
                    "{-" "[]" "::" ":::" ":=" "!!" "!=" "!==" "-}"
                    "--" "---" "-->" "->" "->>" "-<" "-<<" "-~"
                    "#{" "#[" "##" "###" "####" "#(" "#?" "#_" "#_("
                    ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*"
                    "/**" "/=" "/==" "/>" "//" "///" "&&" "||" "||="
                    "|=" "|>" "^=" "$>" "++" "+++" "+>" "=:=" "=="
                    "===" "==>" "=>" "=>>" "<=" "=<<" "=/=" ">-" ">="
                    ">=>" ">>" ">>-" ">>=" ">>>" "<*" "<*>" "<|" "<|>"
                    "<$" "<$>" "<!--" "<-" "<--" "<->" "<+" "<+>" "<="
                    "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<" "<~"
                    "<~~" "</" "</>" "~@" "~-" "~=" "~>" "~~" "~~>" "%%"
                    "x" ":" "+" "+" "*")))
        (lig-symbols (lig-list ligs #Xe100))))

(defun my-set-fira-code-ligs ()
  ;;; add fira code ligatures for use with prettify-symbols mode
  (setq prettify-symbols-alist
        (append fira-code-ligs prettify-symbols-alist))
  (prettify-symbols-mode))
(add-hook 'preg-mode-hook 'my-set-fira-code-ligs)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   '("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "41098e2f8fa67dc51bbe89cce4fb7109f53a164e3a92356964c72f76d068587e" "e6df46d5085fde0ad56a46ef69ebb388193080cc9819e2d6024c9c6e27388ba9" default))
 '(keycast-mode nil)
 '(line-number-mode nil)
 '(package-selected-packages
   '(linum-relative ido-vertical-mode flx-idoq dired-details workgroups persp-projectile perspective direx multiple-cursors fancy-narrow f ewal-spacemacs-themes ewal-spacemacs-theme spacemacs-theme volatile-highlights gif-screencast keycast vterm ace-window undo-tree which-key diff-hl crux super-save flycheck-eldev flycheck imenu-anywhere zop-to-char hl-todo company selectrum-prescient selectrum yaml-mode markdown-mode web-mode inf-ruby rainbow-mode rainbow-delimiters move-text easy-kill anzu paredit elisp-slime-nav expand-region pt projectile ag git-timemachine magit avy diminish use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
