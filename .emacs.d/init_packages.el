(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'use-package)

(use-package adaptive-wrap
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'adaptive-wrap-prefix-mode)
  (add-hook 'LaTeX-mode-hook 'adaptive-wrap-prefix-mode))

(use-package auctex
  :ensure t
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
  )

(use-package auto-indent-mode
  :ensure t
  :defer t
  :init (auto-indent-global-mode))

(use-package benchmark-init
  :ensure t
  :config
  (benchmark-init/activate)
  )

(use-package company-anaconda
  :defer t
  :ensure t
  :init
  (eval-after-load 'company
    (progn
      '(add-to-list 'company-backends 'company-anaconda)
      ))
  (add-hook 'python-mode-hook 'anaconda-mode)
  )

(use-package company
  :defer t
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'company-mode)
  :config
  (setq company-idle-delay 0))

(use-package company-irony
  :defer t
  :ensure t
  :init
  (eval-after-load 'company
    '(add-to-list 'company-backends 'company-irony))
  )

(use-package company-quickhelp
  :defer t
  :ensure t
  :init
  (company-quickhelp-mode t)
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
  :init (global-diff-hl-mode t))

(use-package dtrt-indent
  :defer t
  :ensure t
  :init (add-hook 'prog-mode-hook 'dtrt-indent-mode)
  :config (setq-default dtrt-indent-min-quality 100.0)
  )

(use-package expand-region
  :defer t
  :ensure t
  :config
  (global-set-key (kbd "C-c SPC") 'er/expand-region))

(use-package feature-mode
  :defer t
  :ensure t
  )

(use-package fish-mode
  :defer t
  :ensure t)

(use-package flx-ido
  :defer t
  :ensure t
  :init
  (flx-ido-mode t)
  )

(use-package flycheck
  :defer t
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'flycheck-mode)
  (add-hook 'LaTeX-mode-hook #'flycheck-mode)
  :config
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  )

(use-package flycheck-color-mode-line
  :defer t
  :ensure t
  :init
  (eval-after-load "flycheck"
    '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
  :config
  (custom-set-faces
   '(flycheck-color-mode-line-error-face ((t (:background "#cc0000"))))
   '(flycheck-color-mode-line-info-face ((t (:background "#73d216"))))
   '(flycheck-color-mode-line-warning-face ((t (:background "#f57900"))))
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
  :init
  (global-hl-line-mode t)
  )

(use-package ibuffer
  :bind ("C-x C-b" . ibuffer)
  )

(use-package ido
  :defer t
  :init
  (ido-mode)
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

(use-package ispell
  :defer t
  :config
  (setq ispell-dictionary "en_US")
  (setq ispell-program-name "/usr/bin/hunspell")
  )

(use-package markdown-mode
  :defer t
  :ensure t)

(use-package org
  :defer t
  :config
  (setq org-completion-use-ido t)
  (setq-default org-src-fontify-natively t)
  (setq-default org-hide-emphasis-markers t)
  (defun my-org-mode-hook ()
    (org-toggle-pretty-entities)
    (buffer-face-mode)
    (org-indent-mode)
    ;; (smart-quotes-mode)
    )
  (add-hook 'org-mode-hook 'my-org-mode-hook)
  )

(use-package pkgbuild-mode
  :defer t
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("/PKGBUILD$" . pkgbuild-mode))
  )

(use-package powerline
  :ensure t
  :config
  (powerline-default-theme)
  (setq-default powerline-default-separator nil)
  (custom-set-faces
   '(powerline-active1 ((t (:inherit mode-line :background "dark gray"))))
   '(powerline-active2 ((t (:inherit mode-line :background "light gray"))))
   '(powerline-inactive1 ((t (:background "dark gray"))))
   '(powerline-inactive2 ((t (:background "light gray"))))))

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

(use-package reftex
  :defer t
  :init
  (progn
    (setq reftex-plug-into-AUCTeX t)
    )
  (add-hook 'LaTeX-mode-hook 'reftex-mode)
  )

;; (use-package smart-quotes
;; )

(use-package smex
  :defer t
  :ensure t
  :bind ("M-x" . smex)
  )

(use-package whitespace
  :diminish 'global-whitespace-mode
  :init
  (global-whitespace-mode t)
  :config
  (setq whitespace-style '(tab-mark))
  )
