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
    ("52fc1d30fbcad59953b30805902d1a964c050cacd87a8ad143db2bafa3eb9da2" "eacf8de261107931c9aac0191e28731287fe8b45024064644eef4ca8b481632c" "f32dd8e7b3a508874eded03d5be43d2bdfffe81c199eea72de06ce3e653db720" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" default)))
 '(flymake-gui-warnings-enabled nil)
 '(flymake-no-changes-timeout 2)
 '(global-git-gutter-mode t)
 '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
 '(help-at-pt-timer-delay 0)
 '(hippie-expand-ignore-buffers (quote (dired-mode)))
 '(powerline-default-separator nil)
 '(proof-layout-windows-on-visit-file t)
 '(proof-three-window-mode-policy (quote hybrid))
 '(rw-hunspell-default-dictionary "da_DK_hunspell")
 '(rw-hunspell-dicpath-list (quote ("/usr/share/hunspell")))
 '(rw-hunspell-make-dictionary-menu t)
 '(rw-hunspell-use-rw-ispell t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-preview ((t (:foreground "wheat"))) t)
 '(company-preview-common ((t (:foreground "dark gray"))) t)
 '(flycheck-color-mode-line-error-face ((t (:inherit flycheck-fringe-error :background "#806065" :foreground "#efefef" :weight normal))))
 '(flycheck-color-mode-line-info-face ((t (:inherit flycheck-fringe-info :background "#008000" :foreground "#efefef" :weight normal))))
 '(flycheck-color-mode-line-warning-face ((t (:inherit flycheck-fringe-warning :background "#804600" :foreground "#efefef" :weight normal))))
 '(flymake-errline ((t nil)))
 '(flymake-warnline ((t nil)))
 '(highlight ((t (:background "grey12"))))
 '(hl-line ((t (:background "#393f3f"))))
 '(ido-indicator ((t (:background "red" :foreground "yellow1" :width condensed))))
 '(ido-only-match ((t (:foreground "#8ae234"))))
 '(ido-subdir ((t (:foreground "#729fcf"))))
 '(proof-locked-face ((t (:background "#282d4b")))))
