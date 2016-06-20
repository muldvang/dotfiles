;; Switch yes-no to y-n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Ask before quit
(setq confirm-kill-emacs 'y-or-n-p)

;; Tabs
(setq-default indent-tabs-mode nil
              tab-width 4)

;; Startup
(setq initial-scratch-message ""
      inhibit-startup-message t
      ;; initial-major-mode 'org-mode
      )

;; On save hooks
(setq require-final-newline t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Kill whole line
(setq kill-whole-line t)

;; Sentences end with a single space and not double spaces
(setq sentence-end-double-space nil)

;; Put auto-save files (i.e. #foo#) and backup files (i.e. foo~) in ~/.emacs.d/.
(custom-set-variables
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-saves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))

;; Write custom settings to custom.el
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Better mouse scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))
      mouse-wheel-follow-mouse 't)

;; Electric Pair Mode
(electric-pair-mode 1)
