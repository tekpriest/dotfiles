;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

  ;;(package-initialize)
  (unless package-archive-contents
    (package-refresh-contents))

  ;; Initialize use-package on non-linux platforms
  (unless (package-installed-p 'use-package)
    (package-install 'use-package))

  (require 'use-package)
  (setq use-package-always-ensure t)

  ;; Core Packages
  (use-package ivy
    :diminish
    :bind (("C-s" . swiper)
           :map ivy-minibuffer-map
           ("TAB" . ivy-alt-done)
           ("C-l" . ivy-alt-done)
           ("C-j" . ivy-next-line)
           ("C-k" . ivy-previous-line)
           :map ivy-switch-buffer-map
           ("C-k" . ivy-previous-line)
           ("C-l" . ivy-done)
           ("C-d" . ivy-switch-buffer-kill)
           :map ivy-reverse-i-search-map
           ("C-k" . ivy-previoys-line)
           ("C-d" . ivy-reverse-i-search-kill))
    :config
    (ivy-mode 1))
  (use-package ivy-rich
    :init
    (ivy-rich-mode 1))
  (use-package counsel
    :bind(("M-x" . counsel-M-x)
          ("C-x b" . counsel-ibuffer)
          ("C-x C-f" . counsel-find-file)
          :map minibuffer-local-map
          ("C-r" . 'counsel-minibuffer-history))
    :config
    (setq ivy-initial-inputs-alist nil)) ;; Don't start searches with ^
  ;; Doom modeline
  (use-package doom-modeline
    :ensure t
    :init (doom-modeline-mode 1)
    :custom (domm-modeline-height 7))
  (use-package doom-themes
    :init (load-theme 'doom-tomorrow-night t))

  ;; Misc
  (use-package command-log-mode)

  (use-package rainbow-delimiters
    :hook (prog-mode . rainbow-delimiters-mode))

  (use-package which-key
    :init (which-key-mode)
    :diminish which-key-mode
    :config
    (setq which-key-idle-delay 0.5))

  (use-package helpful
    :ensure t
    :custom
    (counsel-describe-function-function #'helpful-callable)
    (counsel-describe-variable-function #'helpful-variable)
    :bind
    ([remap describe-function] . counsel-describe-function)
    ([remap describe-variable] . helpful-command)
    ([remap describe-key] . helpful-key))

  (use-package all-the-icons)

  (use-package general
    :config
    (general-create-definer priest/leader-keys
      :keymaps '(normal insert visual emacs)
      :prefix "SPC"
      :global-prefix "C-SPC")

    (priest/leader-keys
      "t" '(:ignore t :which-key "toggles")
      "tt" '(counsel-load-theme :which-key "choose theme")
      "ts" '(hydra-text-scale/body :which-key "scale text")
      "tb" '(counsel-switch-buffer :which-key "switch buffers")
      "tc" '(comment-line :which-key "toggle comment")
      ))

  ;; The priest has gone to the evil side
  (use-package evil
    :init
    (setq evil-want-integration t)
    (setq evil-want-keybinding nil)
    (setq evil-want-C-u-scroll t)
    (setq evil-want-C-i-jump nil)
    :config (evil-mode 1)
    ;; Use visual line motion even outside of visual-line-mode buffers
    (evil-global-set-key 'motion "j" 'evil-next-visual-line)
    (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
    (evil-set-initial-state 'messages-buffer-mode 'normal)
    (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config (evil-collection-init))

(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))



(use-package undo-tree
  :after evil
  :diminish
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode 1))

(use-package org
  :hook (org-mode . priest/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
        org-hide-emphasis-markers t
        org-src-fontify-natively t
        org-src-preserve-indentation nil
        org-edit-src-content-indentation 2))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; Set defaults
(defvar priest/default-font-size 110)
(setq inhibit-startup-message t)

;; Enable transient mark mode
(transient-mark-mode 1)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)

;; Use visible bell rather than the annoying sound
(setq visible-bell t)

;; Column number
(column-number-mode)
;; Linenumber
(global-display-line-numbers-mode t)

;; Disable line number for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                eshell-mode-hook
                shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(set-face-attribute 'default nil :font "Victor Mono" :height priest/default-font-size :weight 'bold)

;; Set the fixed pitch fase
(set-face-attribute 'fixed-pitch nil :font "Victor Mono" :height priest/default-font-size :weight 'bold)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Victor Mono" :height 100 :weight 'bold)

(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("js" . "src javascript"))
(add-to-list 'org-structure-template-alist '("ts" . "src typescript"))

;; Orgmode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(setq org-log-done t)
(add-to-list 'auto-mode-alist '("~/Code/org$" . org-mode))
(setq org-agenda-files (list "~/Code/org/work.org"
                            "~/Code/org/personal.org"
                            "~/Code/org/youtube.org"))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; set up ghub
(setq auth-sources '("~/.authinfo"))
;; Org
(defun priest/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil)
  (diminish org-indent-mode))


(dolist (face '((org-level-1 . 1.2)
                (org-level-2 . 1.1)
                (org-level-3 . 1.05)
                (org-level-4 . 1.0)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.1)
                (org-level-8 . 1.1)))
      (set-face-attribute (car face) nil :font "Fira Code" :weight 'medium :height (cdr face)))

 ;; Ensure that anything that should be fixed-pitch in Org files appears that way
    (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
    (set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
    (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
    (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
    ;; (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
    (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)


;; Replace list hyphen with dot
(font-lock-add-keywords 'org-mode
                         '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(defun priest/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visula-fill-column-mode 1))
(use-package visual-fill-column
  :defer t
  :hook (org-mode. priest/org-mode-visual-fill))

(org-babel-do-load-languages
       'org-babel-load-languages
       '((emacs-lisp . t)
         (python . t)))

(push '("conf-unix" . conf-unix) org-src-lang-modes)

;; Automatically tangle init.org config gile when it is saved
(defun priest/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/.dotfiles/emacs/init.org"))
    ;; Dynamic scoping ftw
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'priest/org-babel-tangle-config)))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Code")
    (setq projectile-project-search-path '("~/Code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package forge
  :after magit)
