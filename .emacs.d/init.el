;;; init.el --- Initialization file for Emacs        -*- lexical-binding: t; -*-

;; Copyright (C) 2014

;; Author:  <muldvang@gmail.com>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get-bundle 'auctex)
(el-get-bundle 'benchmark-init)
(el-get-bundle 'cmake-mode)
(el-get-bundle 'company-anaconda)
(el-get-bundle 'company-cmake)
(el-get-bundle 'company-irony)
(el-get-bundle 'company-mode)
(el-get-bundle 'company-quickhelp)
(el-get-bundle 'diff-hl)
(el-get-bundle 'dtrt-indent)
(el-get-bundle 'expand-region)
(el-get-bundle 'fill-column-indicator)
(el-get-bundle 'filladapt)
(el-get-bundle 'fish-mode)
(el-get-bundle 'flycheck)
(el-get-bundle 'flycheck-color-mode-line)
(el-get-bundle 'flx)
(el-get-bundle 'flx-ido)
(el-get-bundle 'hungry-delete)
(el-get-bundle 'god-mode)
(el-get-bundle 'ido-ubiquitous)
(el-get-bundle 'ido-vertical-mode)
(el-get-bundle 'irony-mode)
(el-get-bundle 'markdown-mode)
(el-get-bundle 'pkgbuild-mode)
(el-get-bundle 'pos-tip
  :type "github"
  :pkgname "pitkali/pos-tip")
(el-get-bundle 'powerline)
;; (el-get-bundle 'pythonic)
(el-get-bundle 'rainbow-delimiters)
(el-get-bundle 'rainbow-mode)
(el-get-bundle 'smex)
(el-get-bundle 'tangotango-theme)
(el-get-bundle 'yasnippet)

;; Benchmark startup time.
(benchmark-init/activate)

;; Email address.
(setq user-mail-address "muldvang@gmail.com")

;; Write custom settings to custon.el
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Load manually installed packages.
(add-to-list 'load-path "~/.emacs.d/lisp")

;; Switch yes-no to y-n
(fset 'yes-or-no-p 'y-or-n-p)

;; Ask before quit
(setq confirm-kill-emacs (quote y-or-n-p))

;; Indent using spaces as defaut
(setq-default indent-tabs-mode nil)

;; Put auto-save files (i.e. #foo#) and backup files (i.e. foo~) in ~/.emacs.d/.
(custom-set-variables
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-saves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))

;; "C-k" also kills newline if
(setq kill-whole-line t)

;; Set the preferred length of a line to 80.
(setq-default fill-column 80)

;; Highlight parentheses
(show-paren-mode 1)

;; Use auto insertion
(auto-insert-mode)

;; Tab width of 4 spaces
(setq tab-width 4)

;; Stop blinking cursor
(blink-cursor-mode 0)

;; Highlight current line
(global-hl-line-mode 1)
;; (set-face-background 'hl-line "#393f3f")
(set-face-background 'hl-line "#EEE")

;; Use visible bell
(setq visible-bell t)

;; Move the mouse automatically when it is near the cursor
(mouse-avoidance-mode 'jump)

;; Hide toolbars and scroll bar
(tool-bar-mode 0)
(menu-bar-mode 0)
(set-scroll-bar-mode nil)

;; Show line and coloumn number in status bar
(line-number-mode t)
(column-number-mode t)

;; Disable start screen
(setq initial-scratch-message "")
(setq inhibit-startup-message t)

;; Set color theme
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/el-get/tangotango-theme")
;; (load-theme 'tangotango t)
(load-theme 'adwaita t)

;; Set the font
(set-face-attribute 'default nil :family "monospace" :height 100)
(setq auto-window-vscroll nil)


;; Visualize indenting with tabs
(global-whitespace-mode 1)
(add-hook 'global-whitespace-mode-hook
          (setq-default whitespace-style '(tab-mark))
          )

;; Set frame name
(setq frame-title-format '("" "%b - Emacs"))

;; Use curly arrows in fringe for line wrapping
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))

;; Users ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Indent on enter, not on C-j
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-j") 'newline)

;; Truncate long lines
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)

;; Toggle auto fill mode
(global-set-key (kbd "C-c f") 'auto-fill-mode)

;; Revert from file
(global-set-key (kbd "C-c o") 'revert-buffer)

;; Split horizontally
(global-set-key (kbd "C-x 3") 'split-window-horizontally)

;; Scroll buffer
(define-key global-map (kbd "M-p") 'scroll-down-line)
(define-key global-map (kbd "M-n") 'scroll-up-line)

;; Replace string
(define-key global-map (kbd "C-c r") 'replace-string)
(define-key global-map (kbd "C-c e") 'replace-regexp)

;; Insert file name. Usefull for e.g. write LaTeX documents.
(defun my-insert-file-name (filename &optional args)
  (interactive "*fInsert file name: \nP")
  (cond ((eq '- args)
         (insert (file-relative-name filename)))
        ((not (null args))
         (insert (expand-file-name filename)))
        (t
         (insert filename))))
(global-set-key (kbd "C-c i") 'my-insert-file-name)

;; Go to line easier
(global-set-key (kbd "M-g") 'goto-line)

;;Better mouse scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-follow-mouse 't)

;; Indicate empty lines in left fringe
(setq-default indicate-empty-lines t)

;; Remove trailing white space before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Automatically insert newline at end of file at save.
(setq require-final-newline t)

;; C-x k should kill the current buffer instead of asking which buffer to kill.
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; Function to indent yanked stuff
(defun yank-and-indent ()
  "Yank and then indent the newly formed region according to mode."
  (interactive)
  (yank)
  (call-interactively 'indent-region))

(defun yank-and-indent-mode ()
  (local-set-key "\C-y" 'yank-and-indent)
  )

;; Shortcut for imenu
(global-set-key (kbd "C-c g") 'imenu)

;; Set the major mode of the scratch buffer to org-mode.
(setq initial-major-mode 'org-mode)

;; Ido
(ido-mode t)
(ido-ubiquitous-mode t)
(ido-vertical-mode t)
(setq-default org-completion-use-ido t)
(setq-default ido-use-filename-at-point 'guess)
(setq-default ido-file-extensions-order '(".cpp" ".hpp" ".h" ; C++ projects
                                  ".tex" ".txt" ".log" ; LaTeX projects
                                  ))
(defadvice ido-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(custom-set-faces
 '(ido-only-match ((t (:inherit font-lock-constant-face))))
 '(ido-subdir ((t (:inherit font-lock-builtin-face)))))


;; Smex
(global-set-key (kbd "M-x") 'smex)

;; Sentences end with a single space and not double spaces
(setq sentence-end-double-space nil)

;; Conf-mode for rc, systemd, and .gitignore files.
(add-to-list 'auto-mode-alist '("\\.*rc$" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.*service$" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.*socket$" . conf-unix-mode))
(add-to-list 'auto-mode-alist '(".gitignore$" . conf-space-mode))

;; Global Visual Line mode. Split long lines between words instead of within
;; words.
(global-visual-line-mode 1)

;; Powerline
(powerline-default-theme)
(setq-default powerline-default-separator nil)
(custom-set-faces
 '(powerline-active1 ((t (:inherit mode-line :background "dark gray"))))
 '(powerline-active2 ((t (:inherit mode-line :background "light gray"))))
 '(powerline-inactive1 ((t (:background "dark gray"))))
 '(powerline-inactive2 ((t (:background "light gray")))))

;; Flycheck mode
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq-default flycheck-clang-language-standard "c++11")
(setq-default flycheck-gcc-language-standard "c++11")
(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

(custom-set-faces
 '(flycheck-color-mode-line-error-face ((t (:inherit flycheck-fringe-error :background "#806065" :foreground "#efefef" :weight normal))))
 '(flycheck-color-mode-line-info-face ((t (:inherit flycheck-fringe-info :background "#008000" :foreground "#efefef" :weight normal))))
 '(flycheck-color-mode-line-warning-face ((t (:inherit flycheck-fringe-warning :background "#804600" :foreground "#efefef" :weight normal)))))

;; diff-hl
(global-diff-hl-mode t)

;; Outline minor mode
(outline-minor-mode 1)
(global-set-key (kbd "C-M-u") 'outline-up-heading)
(global-set-key (kbd "C-M-n") 'outline-forward-same-level)
(global-set-key (kbd "C-M-p") 'outline-backward-same-level)

;; Adaptive wrap
(define-globalized-minor-mode global-filladapt-mode
  filladapt-mode filladapt-mode)
(global-filladapt-mode t)

;; Fill Column Indicator
(setq-default fci-rule-color "#393f3f")

;; Electric Pair Mode
(electric-pair-mode 1)

;; Hungry delete
(global-hungry-delete-mode)

;; Expand-region
(global-set-key (kbd "C-c SPC") 'er/expand-region)

;; Spell-checking
(require 'ispell)
(setq-default ispell-dictionary "en_US")
(setq-default ispell-program-name "/usr/bin/hunspell")
;; (add-to-list 'ispell-local-dictionary-alist '("dansk"
;;                                               "[[:alpha:].]"
;;                                               "[^[:alpha:]]"
;;                                               "[.]"
;;                                               t
;;                                               ("-d" "da_DK")
;;                                               nil
;;                                               utf-8))

;; Company
(eval-after-load 'company
  '(company-quickhelp-mode 1))
(setq-default company-idle-delay 0)

;; dtrt-indent
(setq-default dtrt-indent-min-quality 100.0)

;; Irony

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

;; god-mode
(global-set-key (kbd "<escape>") 'god-mode-all)
(setq-default god-exempt-major-modes nil)
(setq-default god-exempt-predicates nil)
(defun my-update-cursor ()
  (setq cursor-type (if (or god-local-mode buffer-read-only)
                        'box
                      'bar)))
(add-hook 'god-mode-enabled-hook 'my-update-cursor)
(add-hook 'god-mode-disabled-hook 'my-update-cursor)
(god-mode)

;; flx-ido
(flx-ido-mode 1)

;; Open links in qutebrowser
(setq-default gnus-button-url 'browse-url-generic
      browse-url-generic-program "qutebrowser"
      browse-url-browser-function gnus-button-url)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Major mode settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; LaTeX

(defun my-LaTeX-mode-hook ()
  (setq-default font-latex-match-warning-keywords
        '(("fixme" "{") ("fxnote" "{") ("fxwarning" "{") ("fxerror" "{") ("fxfatal" "{") ))
  (setq-default TeX-master nil)
  (setq-default TeX-PDF-mode t)
  (setq-default reftex-plug-into-AUCTeX t)
  (setq-default TeX-auto-save t)
  (setq-default TeX-parse-self t)
  (setq-default TeX-command-extra-options "-shell-escape")
  (setq-default TeX-view-program-selection '((output-dvi "xdg-open")
                                     (output-pdf "xdg-open")
                                     (output-html "xdg-open")))
  (turn-on-reftex)
  (LaTeX-math-mode) ; Easily insert math symbols using e.g. ` t to insert \tau.
  (auto-fill-mode) ; auto-fill-mode is nice in LaTeX since tables and math then may extend 80
  (set (make-variable-buffer-local 'TeX-electric-math) ; Electric-pair-mode should also close dollar signs.
       (cons "$" "$"))
  )

;; (add-hook 'LaTeX-mode-hook 'my-LaTeX-mode-hook)

;; CMake
(defun my-cmake-mode-hook ()
  (setq auto-mode-alist
        (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                  ("\\.cmake\\'" . cmake-mode))
                auto-mode-alist))
  (company-mode)
  )
(add-hook 'cmake-mode-hook 'my-cmake-mode-hook)

;; Python
(defun my-python-mode-hook ()
  (fci-mode)
  (company-mode)
  (anaconda-mode)
  (eval-after-load 'company
    (progn
      '(add-to-list 'company-backends 'company-anaconda)
      ))
  )
(add-hook 'python-mode-hook 'my-python-mode-hook)

;; C
(defun my-c-mode-hook ()
  (fci-mode)
  (setq-default c-basic-offset 4)
  (local-set-key  (kbd "M-o") 'ff-find-other-file)
  (c-toggle-hungry-state 1)
  (company-mode)

  (irony-mode)
  (yank-and-indent-mode)
  )
(add-hook 'c-mode-hook 'my-c-mode-hook)

;; C++
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(defun my-c++-mode-hook ()
  (fci-mode)
  (setq-default c-basic-offset 4)
  (local-set-key  (kbd "M-o") 'ff-find-other-file)
  (c-toggle-hungry-state 1)
  (company-mode)
  (irony-mode)
  (yank-and-indent-mode)
  (yas-minor-mode)
  )
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

;; Elisp
(defun my-elisp-mode-hook ()
  (company-mode)
  (yank-and-indent-mode)
  ;; (add-hook 'emacs-lisp-mode-hook 'fci-mode) ;; Makes emacs daemon crash
  (rainbow-delimiters-mode)
  )
(add-hook 'emacs-lisp-mode-hook 'my-elisp-mode-hook)

;; Org-mode
(defun my-org-mode-hook ()
  (flyspell-mode)
  (org-toggle-pretty-entities)
  (org-indent-mode)
  (buffer-face-mode)
  (org-indent-mode)
  )

(add-hook 'org-mode-hook 'my-org-mode-hook)

;; pkgbuild-mode
(add-to-list 'auto-mode-alist '("/PKGBUILD$" . pkgbuild-mode))
