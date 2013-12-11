(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi") (output-pdf "xdg-open") (output-html "xdg-open"))))
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/auto-saves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(company-idle-delay t)
 '(flymake-gui-warnings-enabled nil)
 '(flymake-no-changes-timeout 2)
 '(global-git-gutter-mode t)
 '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
 '(help-at-pt-timer-delay 0)
 '(hippie-expand-ignore-buffers (quote (dired-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-preview ((t (:foreground "wheat"))) t)
 '(company-preview-common ((t (:foreground "dark gray"))) t)
 '(highlight ((t (:background "grey12"))))
 '(hl-line ((t (:background "#393f3f"))))
 '(ido-indicator ((t (:background "red" :foreground "yellow1" :width condensed))) t)
 '(ido-only-match ((t (:foreground "#8ae234"))) t)
 '(ido-subdir ((t (:foreground "#729fcf"))) t)
 '(proof-locked-face ((t (:background "dark slate gray"))) t))
