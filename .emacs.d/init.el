;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Standard settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Write custom settings to custon.el
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Search for files in ~/.emacs.d
(setq load-path (append '("~/.emacs.d") load-path))

;; Set up the package manager
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

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-saves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))

; "C-k" also kills newline if the cursor is at the beginning of a line
(setq kill-whole-line t)

; Set the preferred length of a line to 80.
(setq-default fill-column 80)

; Highlight paranthesises
(show-paren-mode 1)
(setq show-paren-style 'mixed)
(setq show-paren-delay 0)

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
(setq whitespace-style '(tabs tab-mark))
(global-whitespace-mode 1)

;; Set frame name
(setq frame-title-format '("" "%b - Emacs"))

;; Use curly arrows in fringe for line wrapping
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))

;; Indent on enter, not on C-j
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-j") 'newline)

;; Truncate long lines
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)

;; Auto-fill-mode
(global-set-key (kbd "C-c f") 'auto-fill-mode)

;; Revert from file
(global-set-key (kbd "C-c o") 'revert-buffer)

;; Split horizontally
(global-set-key (kbd "C-x 3") 'split-window-horizontally)

;; Delete indentation and line break
(global-set-key (kbd "C-c DEL") 'delete-indentation)

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
(global-set-key "\C-c\C-i" 'my-insert-file-name)

;; Smex
(global-set-key (kbd "M-x") 'smex)

;; Imenu-anywhere
(global-set-key (kbd "C-c g") 'imenu-anywhere)

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

;; Flymake
(custom-set-variables
 '(help-at-pt-timer-delay 0)
 '(help-at-pt-display-when-idle '(flymake-overlay)))

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

;; Fill Column Indicator
(require 'fill-column-indicator)
(setq fci-rule-color "#393f3f")

;; Electric Pair Mode
(electric-pair-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Major mode settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; LaTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'electric-pair-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

(setq TeX-PDF-mode t)

;; Lua
(add-hook 'lua-mode-hook 'flymake-lua-load)
(add-hook 'lua-mode-hook 'fci-mode)

;; CMake
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))
(add-hook 'cmake-mode-hook 'company-mode)

;; Python
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
(add-hook 'python-mode-hook 'fci-mode)

;; C
(add-hook 'c-mode-hook 'fci-mode)
(add-hook 'c-mode-hook (lambda () (setq c-basic-offset 4)))

;; C++
(add-hook 'c++-mode-hook 'fci-mode)
(add-hook 'c++-mode-hook (lambda () (setq c-basic-offset 4)))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Proof General
(load-file "/usr/share/emacs/site-lisp/ProofGeneral/generic/proof-site.el")
(add-hook 'proof-mode-hook 'auto-complete-mode)

;; Haskell
(add-hook 'haskell-mode-hook 'flymake-haskell-multi-load)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

;; Elisp
(add-hook 'emacs-lisp-mode-hook 'fci-mode)
