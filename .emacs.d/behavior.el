; yes-no erstattes med y-n
(fset 'yes-or-no-p 'y-or-n-p)

; emacs skal spørge om jeg vil quitte
(setq confirm-kill-emacs (quote y-or-n-p))

; Indenter kode ved hjælp af mellemrum i stedet for tabs
(setq-default indent-tabs-mode nil)

; Integrer med systepmets klipholder
(setq x-select-enable-clipboard t)

; Word wrap i stedet for orddeling
(global-visual-line-mode 1)

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-saves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))

