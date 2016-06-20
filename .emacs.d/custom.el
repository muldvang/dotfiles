(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-selection
   (quote
    (((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "xdg-open")
     (output-html "xdg-open"))))
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/auto-saves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(company-idle-delay t)
 '(custom-safe-themes
   (quote
    ("5999e12c8070b9090a2a1bbcd02ec28906e150bb2cdce5ace4f965c76cf30476" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" default)))
 '(flycheck-disabled-checkers (quote (c/c++-clang)))
 '(irony-cmake-executable "/usr/bin/cmake")
 '(powerline-default-separator nil)
 '(rw-hunspell-default-dictionary "en_US_hunspell")
 '(rw-hunspell-dicpath-list (quote ("/usr/share/hunspell")))
 '(rw-hunspell-make-dictionary-menu t)
 '(rw-hunspell-use-rw-ispell t)
 '(safe-local-variable-values (quote ((TeX-command-extra-options . "-shell-escape")))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-color-mode-line-error-face ((t (:inherit flycheck-fringe-error :background "#806065" :foreground "#efefef" :weight normal))))
 '(flycheck-color-mode-line-info-face ((t (:inherit flycheck-fringe-info :background "#008000" :foreground "#efefef" :weight normal))))
 '(flycheck-color-mode-line-warning-face ((t (:inherit flycheck-fringe-warning :background "#804600" :foreground "#efefef" :weight normal))))
 '(highlight ((t (:background "grey12"))))
 '(hl-line ((t (:background "#EEE"))))
 '(ido-indicator ((t (:background "red" :foreground "yellow1" :width condensed))))
 '(ido-only-match ((t (:foreground "#8ae234"))))
 '(ido-subdir ((t (:foreground "#729fcf"))))
 '(org-block ((t (:inherit shadow :family "monospace"))))
 '(org-code ((t (:inherit shadow :family "monospace"))))
 '(org-default ((t (:inherit default :family "sans"))))
 '(org-document-info ((t (:foreground "midnight blue"))))
 '(org-document-info-keyword ((t (:inherit shadow))))
 '(org-indent ((t (:family "monospace"))) t)
 '(org-level-1 ((t (:inherit outline-1 :family "sans"))))
 '(org-level-2 ((t (:inherit outline-2))))
 '(org-level-3 ((t (:inherit outline-3))))
 '(org-level-4 ((t (:inherit outline-4))))
 '(org-level-5 ((t (:inherit outline-5))))
 '(org-level-6 ((t (:inherit outline-6))))
 '(org-level-7 ((t (:inherit outline-7))))
 '(org-level-8 ((t (:inherit outline-8))))
 '(org-link ((t (:inherit link))))
 '(org-list-dt ((t (:weight bold))))
 '(org-meta-line ((t (:inherit font-lock-comment-face :foreground "gray"))))
 '(org-table ((t (:foreground "Blue1" :family "monospace"))))
 '(org-verbatim ((t (:inherit shadow :family "monospace"))))
 '(powerline-active1 ((t (:inherit mode-line :background "dark gray"))))
 '(powerline-active2 ((t (:inherit mode-line :background "light gray"))))
 '(powerline-inactive1 ((t (:background "dark gray"))))
 '(powerline-inactive2 ((t (:background "light gray")))))
