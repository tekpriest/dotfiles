;; Define the init file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Define and initialize package repositories
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; use-package to simplify the config file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)

;; Keyboard-centric user interface
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)

;; Theme
(use-package exotica-theme
  :config (load-theme 'exotica t))

;; Helm configuration
(use-package helm
  :config
  (require 'helm-config)
  :init
  (helm-mode 1)
  :bind
  (("M-x" . helm-M-x) ;; Evaluate functions
   ("C-x C-f" . helm-find-files) ;; Open or create files
   ("C-x b" . helm-mini) ;; Select buffers
   ("C-x C-r" . helm-recentf) ;; Select recently saved files
   ("C-c i" . helm-imenu) ;; Select document heading
   ("M-y" . helm-show-kill-ring) ;; Show the kill ring
   :map helm-map
   ("C-z" . helm-select-action)
   ("<tab>" . helm-execute-persistent-action)))

;; Whichkey
(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.5
	which-key-idle-secondary-delay 0.5)
  (which-key-setup-side-window-bottom))

;; Auto completion
(use-package company
  :config
  (setq company-idle-delay 0
	company-minimum-prefix-length 4
	company-selection-wrap-around t))
(global-company-mode)
;; line breaking
(add-hook 'text-mode-hook 'visual-line-mode)
;; overwrite selected text
(delete-selection-mode t)
;; scroll to the first and last line of the buffer
(setq scroll-error-top-bottom t)
;; keymap
(use-package org
  :bind
  (("C-c l" . org-store-link)
   ("C-c a" . org-agenda)
   ("C-c c" . org-capture)))
;; tweaks
(setq org-startup-indented t
      org-pretty-entities t
      org-hide-emphasis-markers t
      org-startup-with-inline-images t
      org-image-actual-width '(300))
;; show hidden emphasis markers
(use-package org-appear
  :hook (org-mode . org-appear-mode))
;; nice bullets
(use-package org-superstar
  :config
  (setq org-superstart-special-todo-items t)
  (add-hook 'org-mode-hook (lambda ()
			     (org-superstar-mode 1))))
;; increate size of LaTeX fragment previews
(plist-put org-format-latex-options :scale 2)

;; spell checking
(use-package flyspell
  :config
  (setq ispell-program-name "hunspell"
	ispell-default-dictionary "en_US")
  :hook (text-mode . flyspell-mode)
  :bind (("M-<f7>" . flyspell-buffer)
	 ("<f7>" . flyspelll-word)
	 ("C-;" . flyspell-auto-correct-previous-word)))

;; font pitch
(use-package mixed-patch
  :hook
  (text-mode . mixed-pitch-mode)
  :config
  (set-face-attribute 'default nil :font "VictorMono Nerd Font Mono" :height 90)
  (set-face-attribute 'fixed-pitch nil :font "VictorMono Nerd Font Mono")
  (set-face-attribute 'variable-pitch nil :font "VictorMono Nerd Font"))

;; required for proportional font
(use-package company-posframe
  :config
  (company-posframe-mode 1))
  
