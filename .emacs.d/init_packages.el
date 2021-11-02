(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

(use-package adaptive-wrap
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'adaptive-wrap-prefix-mode)
  (add-hook 'LaTeX-mode-hook 'adaptive-wrap-prefix-mode))

(use-package all-the-icons-ivy
  :ensure t
  :config

  (use-package all-the-icons
    :ensure t
    :defer t)

  (all-the-icons-ivy-setup)
  )

(use-package avy
  :ensure t
  :bind
  ("C-:" . 'avy-goto-word-1)
  )

(use-package company
  :defer t
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'company-mode)
  :config
  (setq company-idle-delay 0)
  (set-face-attribute 'company-tooltip nil :background "#EDEDED")
  (set-face-attribute 'company-tooltip-selection nil :background "#a5a5a1")
  (setq company-dabbrev-downcase nil)
  (use-package company-quickhelp
    :defer t
    :ensure t
    :init
    (company-quickhelp-mode t)
    )

  (use-package company-anaconda
    :defer t
    :ensure t
    :init
    (eval-after-load 'company
      '(add-to-list 'company-backends 'company-anaconda))
    (add-hook 'python-mode-hook 'anaconda-mode)
    )

  (use-package company-irony
    :defer t
    :ensure t
    :init
    (eval-after-load 'company
      '(add-to-list 'company-backends 'company-irony))
    )

  (use-package company-tern
    :defer t
    :ensure t
    :init
    (eval-after-load 'company
      '(add-to-list 'company-backends 'company-tern))
    )

  (use-package jquery-doc
    :defer t
    :ensure t
    )
  )

(use-package conf
  :defer t
  :mode (("\\.rc\\'" . conf-unix-mode)
         ("\\.service\\'" . conf-unix-mode)
         ("\\.socket\\'" . conf-unix-mode)
         (".gitignore$" . conf-space-mode)
         )
  )

(use-package csv-mode
  :defer t
  :ensure t
  ;; :bind
  ;; ("TAB" . csv-forward-field)
  ;; ("<backtab>" . csv-backward-field)
  :config
  (setq-default csv-invisibility-default nil)
  (setq-default csv-align-style 'auto))

(use-package counsel
  :ensure t
  :bind (
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-x C-b" . counsel-ibuffer)
         ("C-c g" . 'counsel-imenu)

         :map ivy-minibuffer-map
         ;; Exchange the default bindings for C-j and C-m
         ("C-m" . ivy-alt-done)             ;RET, default C-j
         ("C-j" . ivy-done)                 ;Default C-m
         )
  :config
  (use-package smex
    :ensure t)
  (use-package flx
    :ensure t)
  (use-package ivy-prescient
    :ensure t
    :init
    (ivy-prescient-mode))
  (ivy-mode 1)
  ;; intentional space before end of string
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-re-builders-alist
        '((swiper . ivy--regex-plus)
          (swiper-isearch . ivy--regex-plus)
          (counsel-ag . ivy--regex-plus)
          (counsel-rg . ivy--regex-plus)
          (t . ivy--regex-fuzzy)))
  (setq counsel-find-file-at-point t)

  (use-package ivy-xref
    :ensure t
    :init
    ;; xref initialization is different in Emacs 27 - there are two different
    ;; variables which can be set rather than just one
    (when (>= emacs-major-version 27)
      (setq xref-show-definitions-function #'ivy-xref-show-defs))
    ;; Necessary in Emacs <27. In Emacs 27 it will affect all xref-based
    ;; commands other than xref-find-definitions (e.g. project-find-regexp)
    ;; as well
    (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))
  )

(use-package diff-hl
  :defer t
  :ensure t
  ;; TODO: Start up when visiting a file that is under version control instead of using the global mode.
  :init (global-diff-hl-mode t)
  )

(use-package dtrt-indent
  :defer t
  :ensure t
  :init (add-hook 'prog-mode-hook 'dtrt-indent-mode)
  )

(use-package ess
  :defer t
  :ensure t)

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-org
  :ensure t
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package evil-numbers
  :defer t
  :ensure t
  :bind
  ("C-c +" . evil-numbers/inc-at-pt)
  ("C-c -" . evil-numbers/dec-at-pt)
  )

(use-package expand-region
  :defer t
  :ensure t
  :bind
  ("C-c SPC" . er/expand-region))

(use-package feature-mode
  :defer t
  :ensure t
  )

(use-package fish-mode
  :defer t
  :ensure t)

(use-package flycheck
  :defer t
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'flycheck-mode)
  (add-hook 'LaTeX-mode-hook #'flycheck-mode)
  :config
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

  (use-package flycheck-color-mode-line
    :defer t
    :ensure t
    :init
    (eval-after-load "flycheck"
      '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
    :config
    (set-face-background 'flycheck-color-mode-line-error-face "#cc0000")
    (set-face-background 'flycheck-color-mode-line-info-face "#73d216")
    (set-face-background 'flycheck-color-mode-line-warning-face "#f57900")
    (set-face-foreground 'flycheck-color-mode-line-error-face "#2E3436")
    (set-face-foreground 'flycheck-color-mode-line-info-face "#2E3436")
    (set-face-foreground 'flycheck-color-mode-line-warning-face "#2E3436")
    )
  )

(use-package flyspell
  :config
  (eval-after-load "flyspell" '(progn
                                 (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
                                 (define-key flyspell-mouse-map [mouse-3] 'undefined))))

;; (use-package frames-only-mode
;;   :ensure t
;;   :defer t
;;   :init
;;   (frames-only-mode 1))

;; (use-package god-mode
;;   :ensure t
;;   :bind ("<escape>" . god-mode-all)
;;   :init (god-mode-all)
;;   :config
;;   (setq-default god-exempt-major-modes nil)
;;   (setq-default god-exempt-predicates nil)
;;   (defun my-update-cursor ()
;;     (set-cursor-color (if (or god-local-mode)
;;                           "#cc0000"
;;                         "#00bbff"))
;;     (setq cursor-type (if (or god-local-mode buffer-read-only)
;;                           'box
;;                         'bar))
;;     )
;;   (add-hook 'god-mode-enabled-hook 'my-update-cursor)
;;   (add-hook 'god-mode-disabled-hook 'my-update-cursor)
;;   (add-hook 'buffer-list-update-hook 'my-update-cursor)
;;   (define-key god-local-mode-map (kbd ".") 'repeat)
;;   (define-key god-local-mode-map (kbd "i") 'god-local-mode)
;;   )

(use-package groovy-mode
  :ensure t
  :config
  (add-hook 'groovy-mode-hook
            (lambda ()
              (c-set-offset 'label 4))))

(use-package hl-line
  :config
  (set-face-background 'hl-line "#EDEDED")
  (set-face-foreground 'highlight nil)
  :init
  (global-hl-line-mode t)
  )

(use-package htmlize
  :defer t
  :ensure t
  )

(use-package ialign
  :defer t
  :ensure t)

(use-package ispell
  :defer t
  :config
  (setq ispell-dictionary "en_US")
  (setq ispell-program-name "/usr/bin/hunspell")
  )

(use-package ivy-rich
  :ensure t
  :after (ivy)
  :init
  (setq ivy-rich-path-style 'abbrev
        ivy-virtual-abbreviate 'full)
  :config (ivy-rich-mode 1))

(use-package json-mode
  :defer t
  :ensure t)

(use-package lsp-mode
  :ensure t
  :defer t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (python-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :defer t
  :commands lsp-ui-mode
  :config
  (setq lsp-headerline-breadcrumb-enable nil)
  )

(use-package lsp-ivy
  :ensure t
  :defer t
  :commands lsp-ivy-workspace-symbol)

(use-package markdown-mode
  :defer t
  :ensure t)

(use-package magit
  :defer t
  :ensure t
  :config
  (setq magit-diff-refine-hunk 'all)
  (magit-add-section-hook 'magit-status-sections-hook
                          'magit-insert-unpushed-to-upstream
                          'magit-insert-unpushed-to-upstream-or-recent
                          'replace)
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1))

;; (use-package mode-icons
;;   :ensure t
;;   :defer t
;;   :init
;;   (mode-icons-mode))

(use-package org
  :defer t
  :init
  :config
  (defun my-org-mode-font-hook ()
    (set-face-attribute 'org-level-1 nil :family "sans")
    (set-face-attribute 'org-level-2 nil :family "sans")
    (set-face-attribute 'org-level-3 nil :family "sans")
    (set-face-attribute 'org-level-4 nil :family "sans")
    (set-face-attribute 'org-level-5 nil :family "sans")
    (set-face-attribute 'org-level-6 nil :family "sans")
    (set-face-attribute 'org-level-7 nil :family "sans")
    (set-face-attribute 'org-level-8 nil :family "sans")
    (set-face-attribute 'org-default nil :family "sans")
    (set-face-attribute 'org-block nil :family "monospace")
    (set-face-attribute 'org-code nil :family "monospace")
    (set-face-attribute 'org-meta-line nil :foreground "#EEE")
    (set-face-attribute 'org-table nil :foreground "#2E3436" :family "monospace")
    (set-face-attribute 'org-verbatim nil :family "monospace")
    (setq buffer-face-mode-face '(:family "sans" :height 115))
    (buffer-face-mode)

    (setq-default prettify-symbols-alist
                  '(
                    ("#+BEGIN_SRC" . "λ")
                    ("#+END_SRC" . "λ")

                    ("[ ]" . "☐")
                    ("[X]" . "☑")
                    ("[-]" . "☒")

                    ("NEXT" . "▶")
                    ("TODO" . "▷") ;; ☐
                    ("DONE". "✓")
                    ("IN-PROGRESS" . "↻") ;; ⚙
                    ("IMPLEMENTED". "✓")
                    ("CANCELED" . "✗")
                    ("WAITING" . "⚑")
                    ("BLOCKED" . "⚠")
                    ("READY-FOR-REVIEW" . "↪")
                    ("REVIEW" . "🗩")
                    ("DEMO" . "🗠")
                    ))
    (setq-default prettify-symbols-unprettify-at-point t)
    (setq-default prettify-symbols-unprettify-at-point 'right-edge)
    (prettify-symbols-mode)
    (defun update-org-latex-fragments ()
      (org-toggle-latex-fragment '(64))
      (plist-put org-format-latex-options :scale text-scale-mode-amount)
      (org-toggle-latex-fragment '(16)))
    (add-hook 'text-scale-mode-hook 'update-org-latex-fragments)
    )
  (add-hook 'org-mode-hook 'my-org-mode-font-hook)

  (setq-default org-hide-emphasis-markers t)
  (setq-default org-html-validation-link nil)
  (setq-default org-startup-with-inline-images t)
  (setq org-ellipsis "  ")

  (add-hook 'org-mode-hook 'org-toggle-pretty-entities)
  (add-hook 'org-mode-hook 'org-indent-mode)
  (setq-default org-image-actual-width nil)
  )

(use-package ox-twbs
  :defer t
  :ensure t)

(use-package pkgbuild-mode
  :defer t
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("/PKGBUILD$" . pkgbuild-mode))
  )

(use-package rainbow-delimiters
  :defer t
  :ensure t
  :init
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
  )

(use-package rainbow-mode
  :defer t
  :ensure t
  :init
  (add-hook 'text-mode-hook 'rainbow-mode)
  (add-hook 'prog-mode-hook 'rainbow-mode))

(use-package rst
  :init
  (add-hook 'rst-mode-hook #'flycheck-mode)
  (add-hook 'rst-mode-hook 'adaptive-wrap-prefix-mode)
  (add-hook 'rst-mode-hook 'flyspell-mode)
  (add-hook 'rst-mode-hook 'table-recognize)

  (defun torben-preview ()
    (interactive)
    (compile "rst2html.py test.rst /tmp/rst-preview.html")
    (sleep-for 1)
    (other-window 1)
    (eww-open-file "/tmp/rst-preview.html")
    (other-window 1)
    )

  (add-hook 'rst-mode-hook (lambda ()
                             ;; Setup toolbar
                             (tool-bar-mode)
                             (tool-bar-add-item "spell" 'rst-insert-list 'rst-insert-list :help "Start a new list or add element to current list")
                             (tool-bar-add-item "right-arrow" 'table-widen-cell 'table-widen-cell :help "Widen")
                             (tool-bar-add-item "left-arrow" 'table-narrow-cell 'table-narrow-cell :help "Narrow")
                             (tool-bar-add-item "up-arrow" 'table-shorten-cell 'table-shorten-cell :help "Shorten")
                             (tool-bar-add-item "spell" 'torben-preview 'torben-preview :help "Preview")))
  (add-hook 'rst-mode-hook (lambda ()
                             ;; Add Imenu to the menu bar in any mode that supports it.
                             (menu-bar-mode)
                             (defun try-to-add-imenu ()
                               (condition-case nil
                                   (imenu-add-to-menubar "Outline")
                                 (error nil)))
                             (add-hook 'font-lock-mode-hook #'try-to-add-imenu)))
  :config
  )


(use-package swiper
  :bind
  ("C-s" . swiper-isearch)
  )

;; (use-package smart-quotes
;; )

(use-package tex
  :ensure auctex
  :defer t
  :mode ("\\.tex\\'" . latex-mode)
  :config
  (setq-default TeX-electric-math (cons "$" "$")
                TeX-master nil
                TeX-parse-self t
                TeX-command-extra-options "-shell-escape"
                TeX-view-program-selection '((output-dvi "xdg-open")
                                             (output-pdf "xdg-open")
                                             (output-html "xdg-open"))
                font-latex-match-warning-keywords '(("fixme" "{")
                                                    ("fxnote" "{")
                                                    ("fxwarning" "{")
                                                    ("fxerror" "{")
                                                    ("fxfatal" "{")))

  (use-package reftex
    :defer t
    :init
    (add-hook 'LaTeX-mode-hook 'reftex-mode)
    :config
    (setq-default reftex-plug-into-AUCTeX t)
    )
  )

(use-package smart-hungry-delete
  :ensure t
  :bind (
         ("<backspace>" . smart-hungry-delete-backward-char)
         ("C-d" . smart-hungry-delete-forward-char))
  :defer nil
  :config
  (smart-hungry-delete-add-default-hooks)
  )

(use-package try
  :ensure t)

(use-package web-mode
  :ensure t
  :defer t
  :mode (("\\.html\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2)
  )

(use-package wgrep
  :ensure t
  :defer t)

(use-package which-key
  :ensure t
  :diminish 'which-key-mode
  :init
  (which-key-mode)
  :config
  (which-key-enable-god-mode-support)
  )

(use-package whitespace
  :diminish 'global-whitespace-mode
  :init
  (global-whitespace-mode t)
  :config
  (setq whitespace-style '(tab-mark
                           trailing newline))
  )

(use-package whitespace-cleanup-mode
  :ensure t
  :defer t
  :init
  (global-whitespace-cleanup-mode))

(use-package yaml-mode
  :ensure t
  :defer t)

(use-package jira-markup-mode
  :ensure t
  )
