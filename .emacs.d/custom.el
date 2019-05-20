(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/auto-saves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(company-box-enable-icon nil)
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "b9e9ba5aeedcc5ba8be99f1cc9301f6679912910ff92fdf7980929c2fc83ab4d" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "5999e12c8070b9090a2a1bbcd02ec28906e150bb2cdce5ace4f965c76cf30476" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" default)))
 '(irony-cmake-executable "/usr/bin/cmake")
 '(org-export-time-stamp-file nil)
 '(org-export-with-author nil)
 '(org-export-with-creator nil)
 '(org-export-with-toc nil)
 '(package-selected-packages
   (quote
    (magit company-box jira-markup-mode groovy-mode aggressive-indent aggressive-indent-mode aggresive-indent-mode aggresive-indent json-mode web-mode which-key smart-mode-line-powerline-theme smart-mode-line telephone-line auto-compile use-package htmlize ox-twbs evil-numbers kotlin-mode smex smartparens scala-mode rainbow-mode rainbow-delimiters powerline pkgbuild-mode markdown-mode ido-vertical-mode ido-ubiquitous hungry-delete god-mode flycheck-color-mode-line flx-ido fish-mode fill-column-indicator feature-mode expand-region dtrt-indent diff-hl company-quickhelp company-math company-irony company-emacs-eclim company-anaconda cmake-mode benchmark-init auto-indent-mode auctex adaptive-wrap)))
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
 '(ido-indicator ((t (:background "red" :foreground "yellow1" :width condensed))))
 '(ido-only-match ((t (:foreground "#8ae234"))))
 '(ido-subdir ((t (:foreground "#729fcf"))))
 '(ivy-current-match ((t (:background "#1a4b77" :foreground "white"))))
 '(ivy-minibuffer-match-face-2 ((t (:inherit font-lock-keyword-face))))
 '(ivy-minibuffer-match-face-3 ((t (:inherit font-lock-keyword-face))))
 '(ivy-minibuffer-match-face-4 ((t (:inherit font-lock-keyword-face)))))
