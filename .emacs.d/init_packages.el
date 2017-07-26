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

(use-package company
  :defer t
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'company-mode)
  :config
  (setq company-idle-delay 0)
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
  )


(use-package conf
  :defer t
  :mode (("\\.rc\\'" . conf-unix-mode)
         ("\\.service\\'" . conf-unix-mode)
         ("\\.socket\\'" . conf-unix-mode)
         (".gitignore$" . conf-space-mode)
         )
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

(use-package god-mode
  :ensure t
  :bind ("<escape>" . god-mode-all)
  :init (god-mode-all)
  :config
  (setq-default god-exempt-major-modes nil)
  (setq-default god-exempt-predicates nil)
  (defun my-update-cursor ()
    (setq cursor-type (if (or god-local-mode buffer-read-only)
                          'box
                        'bar)))
  (add-hook 'god-mode-enabled-hook 'my-update-cursor)
  (add-hook 'god-mode-disabled-hook 'my-update-cursor)
  (define-key god-local-mode-map (kbd ".") 'repeat)
  (define-key god-local-mode-map (kbd "i") 'god-local-mode)
  )

(use-package hungry-delete
  :diminish 'hungry-delete-mode
  :defer t
  :ensure t
  :init
  (global-hungry-delete-mode)
  )

(use-package hl-line
  :config
  (set-face-background 'hl-line "#EEE")
  (set-face-foreground 'highlight nil)
  :init
  (global-hl-line-mode t)
  )

(use-package htmlize
  :defer t
  :ensure t
  )

(use-package ibuffer
  :bind ("C-x C-b" . ibuffer)
  )

(use-package ido
  :defer t
  :init
  (ido-mode 1)
  (ido-everywhere 1)
  :config
  (setq ido-use-filename-at-point 'guess)
  (setq ido-file-extensions-order '(".cpp" ".hpp" ".h" ; C++ projects
                                    ".tex" ".txt" ".log" ".aux" ".pdf"; LaTeX projects
                                    ))
  (defadvice ido-find-file (after find-file-sudo activate)
    "Find file as root if necessary."
    (unless (and buffer-file-name
                 (file-writable-p buffer-file-name))
      (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

  (custom-set-faces
   '(ido-only-match ((t (:inherit font-lock-constant-face))))
   '(ido-subdir ((t (:inherit font-lock-builtin-face)))))

  (use-package flx-ido
    :defer t
    :ensure t
    :init
    (flx-ido-mode t)
    )

  (use-package ido-ubiquitous
    :defer t
    :ensure t
    :init (ido-ubiquitous-mode)
    )

  (use-package ido-vertical-mode
    :defer t
    :ensure t
    :init (ido-vertical-mode)
    )

  (use-package smex
    :defer t
    :ensure t
    :bind ("M-x" . smex)
    )
  )

(use-package ispell
  :defer t
  :config
  (setq ispell-dictionary "en_US")
  (setq ispell-program-name "/usr/bin/hunspell")
  )

(use-package json-mode
  :defer t
  :ensure t)

(use-package markdown-mode
  :defer t
  :ensure t)

(use-package org
  :defer t
  :config
  (setq org-completion-use-ido t)
  (setq-default org-src-fontify-natively t)
  (setq-default org-hide-emphasis-markers t)
  (setq-default org-html-validation-link nil)
  (defun my-org-mode-hook ()
    (org-toggle-pretty-entities)
    (setq buffer-face-mode-face '(:family "sans" :height 115))
    (buffer-face-mode)
    (org-indent-mode)
    ;; (smart-quotes-mode)
    )
  (add-hook 'org-mode-hook 'my-org-mode-hook)
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
  (set-face-attribute 'org-block-background nil :family "monospace")
  (set-face-attribute 'org-code nil :family "monospace")
  (set-face-attribute 'org-meta-line nil :foreground "light gray")
  (set-face-attribute 'org-table nil :foreground "#2E3436" :family "monospace")
  (set-face-attribute 'org-verbatim nil :family "monospace")
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

(use-package web-mode
  :ensure t
  :defer t
  :mode (("\\.html\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2)
  )

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
  (setq whitespace-style '(tab-mark))
  )
