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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Standard settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq user-mail-address "muldvang@gmail.com")

;; Write custom settings to custon.el
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Set up the ELPA package manager
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/elpa")

;; el-get

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

;; Switch yes-no to y-n
(fset 'yes-or-no-p 'y-or-n-p)

;; Ask before quit
(setq confirm-kill-emacs (quote y-or-n-p))

;; Indent using tabs
(setq-default indent-tabs-mode nil)

;; Integrate system clipboard
(setq gui-select-enable-clipboard t)

;; Put auto-save files (i.e. #foo#) and backup files (i.e. foo~) in ~/.emacs.d/.
(custom-set-variables
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-saves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))

; "C-k" also kills newline if the cursor is at the beginning of a line
(setq kill-whole-line t)

; Set the preferred length of a line to 80.
(setq-default fill-column 80)

; Highlight parentheses
(show-paren-mode 1)

; Use auto insertion
(auto-insert-mode)

; Tab width of 4 spaces
(setq tab-width 4)

;; Stop blinking cursor
(blink-cursor-mode 0)

;; Highlight current line
(global-hl-line-mode 1)

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
;; (load-theme 'tangotango t)
(color-theme-tangotango)

;; Set the font
(set-face-attribute 'default nil :family "monospace" :height 100)
(setq auto-window-vscroll nil)


;; Visualize indenting with tabs
(global-whitespace-mode 1)
(setq whitespace-style '(tab-mark))

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

;; Refill mode
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

;; Find file at point
(global-set-key (kbd "C-x f") 'find-file-at-point)

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
;(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)

;; Indicate empty lines in left fringe
(setq-default indicate-empty-lines t)

;; Remove trailing white space before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; C-x k should kill the current buffer instead of asking which buffer to kill.
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; Indent yanked stuff
(defun yank-and-indent ()
  "Yank and then indent the newly formed region according to mode."
  (interactive)
  (yank)
  (call-interactively 'indent-region))
(global-set-key "\C-y" 'yank-and-indent)

;; Shortcut for imenu
(global-set-key (kbd "C-c g") 'imenu)

;; Set the major mode of the scratch buffer to org-mode.
(setq initial-major-mode 'org-mode)

;; Ido
(ido-mode t)
(ido-ubiquitous-mode 1)

;; Smex
(global-set-key (kbd "M-x") 'smex)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Minor mode settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Global Visual Line mode. Split long lines between words instead of
;; within words.
(global-visual-line-mode 1)

;; Powerline
(powerline-default-theme)

;; Flycheck mode
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-clang-language-standard "c++11")

; Add color for the mode-line
(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

;; diff-hl
(global-diff-hl-mode t)

;; Outline minor mode
(outline-minor-mode 1)
(global-set-key (kbd "C-M-u") 'outline-up-heading)
(global-set-key (kbd "C-M-n") 'outline-forward-same-level)
(global-set-key (kbd "C-M-p") 'outline-backward-same-level)

;; ;; Adaptive wrap
;; (define-globalized-minor-mode global-adaptive-wrap-prefix-mode
;;  adaptive-wrap-prefix-mode adaptive-wrap-prefix-mode)
;; (global-adaptive-wrap-prefix-mode 1)

;; Fill Column Indicator
(setq fci-rule-color "#393f3f")

;; Electric Pair Mode
(electric-pair-mode 1)

;; Hungry delete
(global-hungry-delete-mode)

;; Expand-region
(global-set-key (kbd "C-c SPC") 'er/expand-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Major mode settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; LaTeX
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)

; Easily insert math symbols using e.g. ` t to insert \tau.
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

; auto-fill-mode is nice in LaTeX since tables and math then may extend 80
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)

; Compile to pdf
(setq TeX-PDF-mode t)

;; Lua
(add-hook 'lua-mode-hook 'fci-mode)

;; CMake
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))

;; Python
(add-hook 'python-mode-hook 'fci-mode)
(add-hook 'python-mode-hook 'company-mode)
(add-hook 'python-mode-hook 'anaconda-mode)

;; C
(yas-global-mode)

(add-hook 'c-mode-hook 'fci-mode)
(add-hook 'c-mode-hook (lambda () (setq c-basic-offset 4)))
(add-hook 'c-mode-hook
          (lambda()
            (local-set-key  (kbd "M-o") 'ff-find-other-file)))
(add-hook 'c-mode-hook (lambda () (c-toggle-hungry-state 1)))
(add-hook 'c-mode-hook 'company-mode)

(add-hook 'c-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

;; (optional) adds CC special commands to `company-begin-commands' in order to
;; trigger completion at interesting places, such as after scope operator
;;     std::|
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

;; C++
(add-hook 'c++-mode-hook 'fci-mode)
(add-hook 'c++-mode-hook (lambda () (setq c-basic-offset 4)))
(add-hook 'c++-mode-hook
          (lambda()
            (local-set-key  (kbd "M-o") 'ff-find-other-file)))
(add-hook 'c++-mode-hook (lambda () (c-toggle-hungry-state 1)))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-hook 'c++-mode-hook 'company-mode)

(add-hook 'c++-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

;; (optional) adds CC special commands to `company-begin-commands' in order to
;; trigger completion at interesting places, such as after scope operator
;;     std::|
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)


;; Haskell
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(add-hook 'haskell-mode-hook 'fci-mode)

;; Elisp
(add-hook 'emacs-lisp-mode-hook 'company-mode)
; (add-hook 'emacs-lisp-mode-hook 'fci-mode) ;; Makes emacs daemon crash
;; (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

;; Org-mode
(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'org-toggle-pretty-entities)
(add-hook 'org-mode-hook 'auto-fill-mode)

;; pkgbuild-mode
(setq auto-mode-alist (append '(("/PKGBUILD$" . pkgbuild-mode))
                              auto-mode-alist))

;; Java
(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 4
                                  tab-width 4)))

;; Conf-mode for rc files.
(add-to-list 'auto-mode-alist '("\\.*rc$" . conf-unix-mode))

;; Matlab mode
(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
(add-to-list
 'auto-mode-alist
 '("\\.m$" . matlab-mode))
(setq matlab-indent-function t)
(setq matlab-shell-command "matlab")
(add-hook 'matlab-mode-hook 'company-mode)
(add-hook 'matlab-mode-hook 'fci-mode)

(defun my-matlab-hook ()
  (matlab-toggle-show-mlint-warnings)
  (matlab-cedet-setup)
  (local-set-key (kbd "M-;") 'comment-dwim))
(add-hook 'matlab-mode-hook 'my-matlab-hook)

;; Define company-completion for matlab-mode
(require 'cl-lib)
(require 'company)
(defun company-sample-backend (command &optional arg &rest ignored)
  (interactive (list 'interactive))

  (cl-case command
    (interactive (company-begin-backend 'company-sample-backend))
    (prefix (and (eq major-mode 'matlab-mode)
                 (company-grab-symbol)))
    (candidates
     (cl-remove-if-not
      (lambda (c) (string-prefix-p arg c))
      (append (matlab-solo-completions arg)
              (matlab-find-recent-variable arg)
              (matlab-boolean-completions arg)
              (matlab-value-completions arg)
              (matlab-property-completions arg)
              (matlab-find-user-functions arg))))))
(add-to-list 'company-backends 'company-sample-backend)

;; Langtool
(setq langtool-language-tool-jar "/usr/share/java/languagetool/languagetool-commandline.jar")

;; Spell-checking
(require 'rw-language-and-country-codes)
(require 'rw-ispell)
(require 'rw-hunspell)
(setq ispell-dictionary "da_DK_hunspell")
(setq ispell-program-name "/usr/bin/hunspell")
;; The following is set via custom
(custom-set-variables
 '(rw-hunspell-default-dictionary "da_DK_hunspell")
 '(rw-hunspell-dicpath-list (quote ("/usr/share/hunspell")))
 '(rw-hunspell-make-dictionary-menu t)
 '(rw-hunspell-use-rw-ispell t)
 )
