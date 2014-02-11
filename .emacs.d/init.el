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
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; Switch yes-no to y-n
(fset 'yes-or-no-p 'y-or-n-p)

;; Ask before quit
(setq confirm-kill-emacs (quote y-or-n-p))

;; Indent using tabs
(setq-default indent-tabs-mode nil)

;; Integrate system clipboard
(setq x-select-enable-clipboard t)

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
(load-theme 'tangotango t)

;; Set the font
(set-face-attribute 'default nil :family "DejaVu Sans Mono" :height 95)
(setq auto-window-vscroll nil)


;; Visualize indenting with tabs
(global-whitespace-mode 1)
(setq whitespace-style '(tab-mark))

;; Set frame name
(setq frame-title-format '("" "%b - Emacs"))

;; Use curly arrows in fringe for line wrapping
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))

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

;; Smex
(global-set-key (kbd "M-x") 'smex)

;; Imenu-anywhere
(global-set-key (kbd "C-c g") 'imenu-anywhere)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Minor mode settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Global Visual Line mode. Split long lines between words instead of
;; within words.
(global-visual-line-mode 1)

;; Ido
(ido-mode 'both)
(setq ido-ignore-buffers '("\\` " "^\*"))

(defadvice ido-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

;; Icicles
;; (require 'icicles)
;; (icy-mode 1)

;; Powerline
(require 'powerline)
(powerline-default-theme)

;; Flycheck mode
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-clang-language-standard "c++11")

; Add color for the mode-line
(require 'flycheck-color-mode-line)
(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

;; diff-hl
(global-diff-hl-mode t)

;; Outline minor mode
(outline-minor-mode 1)
(global-set-key (kbd "C-M-u") 'outline-up-heading)
(global-set-key (kbd "C-M-n") 'outline-forward-same-level)
(global-set-key (kbd "C-M-p") 'outline-backward-same-level)

;; Adaptive wrap
(define-globalized-minor-mode global-adaptive-wrap-prefix-mode
  adaptive-wrap-prefix-mode adaptive-wrap-prefix-mode)
(global-adaptive-wrap-prefix-mode 1)

;; Auto-complete
(require 'auto-complete-config)
(ac-config-default)
(setq ac-delay 0)
(setq ac-quick-help-delay 0.2)
(ac-flyspell-workaround)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
(setq ac-use-fuzzy t)

;; Yasnippet (Useful with auto-complete)
(require 'yasnippet)
(yas-global-mode 1)

;; Fill Column Indicator
(require 'fill-column-indicator)
(setq fci-rule-color "#393f3f")

;; Electric Pair Mode
(electric-pair-mode 1)

;; Hungry delete
(require 'hungry-delete)
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

; Easily insert math symbols using e.g. ` t to insert \tau.
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

; auto-fill-mode is nice in LaTeX since tables and math then may extend 80
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)

; Compile to pdf
(setq TeX-PDF-mode t)

; Auto-complete
(require 'ac-math)
(add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of `latex-mode`

(defun ac-LaTeX-mode-setup () ; add ac-sources to default ac-sources
  (setq ac-sources (append '(ac-source-math-unicode
                             ac-source-latex-commands)
                           ac-sources)))
(add-hook 'LaTeX-mode-hook 'ac-LaTeX-mode-setup)
(setq ac-math-unicode-in-math-p t)

;; Lua
(add-hook 'lua-mode-hook 'fci-mode)

;; CMake
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))

;; Python
(add-hook 'python-mode-hook 'fci-mode)
(add-hook 'python-mode-hook 'jedi:ac-setup)

;; C / C++
(add-hook 'c-mode-common-hook 'fci-mode)
(add-hook 'c-mode-common-hook (lambda () (setq c-basic-offset 4)))
(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key  (kbd "M-o") 'ff-find-other-file)))
(add-hook 'c-mode-common-hook (lambda () (c-toggle-hungry-state 1)))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(require 'auto-complete-clang-async)

(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable "~/.emacs.d/clang-complete")
  (setq ac-sources '(ac-source-clang-async))
  (ac-clang-launch-completion-process)
)

(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)


;; Haskell
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(add-hook 'haskell-mode-hook 'fci-mode)
(add-hook 'haskell-mode-hook 'auto-complete-mode)

;; Elisp
(add-hook 'emacs-lisp-mode-hook 'auto-complete-mode)
(add-hook 'emacs-lisp-mode-hook 'fci-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook 'flyspell-prog-mode)

;; Org-mode
(add-hook 'org-mode-hook 'flyspell-mode)

;; pkgbuild-mode
(setq auto-mode-alist (append '(("/PKGBUILD$" . pkgbuild-mode))
                              auto-mode-alist))

;;; init.el ends here
