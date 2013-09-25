;; Indenter automatisk, men undgå ved brug af C-j
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-j") 'newline)

;; Trunker lange linjer
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)

;; Automatisk linjeskift efter x antal tegn.
(global-set-key (kbd "C-c f") 'auto-fill-mode)

;; Slet alle ændringer og hent filen fra disken igen.
(global-set-key (kbd "C-c o") 'revert-buffer)

;; Split vinduet horisontalt.
(global-set-key (kbd "C-x 3") 'split-window-horizontally)

;; Slet indenteringen af en linje og flyt den op til den ovenstående.
(global-set-key (kbd "C-c DEL") 'delete-indentation)

;; Slet en hel linje
(global-set-key (kbd "C-S-k") 'kill-whole-line)

;; Scroll buffer uden at flytte curseren
(define-key global-map (kbd "M-p") 'scroll-down-line)
(define-key global-map (kbd "M-n") 'scroll-up-line)

;; Replace string
(define-key global-map (kbd "C-c r") 'replace-string)
(define-key global-map (kbd "C-c e") 'replace-regexp)

;; Find file at point
(global-set-key (kbd "C-x f") 'find-file-at-point)

;; Insert file name
(defun my-insert-file-name (filename &optional args)
  "Insert name of file FILENAME into buffer after point.
  
  Prefixed with \\[universal-argument], expand the file name to
  its fully canocalized path.  See `expand-file-name'.
  
  Prefixed with \\[negative-argument], use relative path to file
  name from current directory, `default-directory'.  See
  `file-relative-name'.
  
  The default with no prefix is to insert the file name exactly as
  it appears in the minibuffer prompt."
  ;; Based on insert-file in Emacs -- ashawley 20080926
  (interactive "*fInsert file name: \nP")
  (cond ((eq '- args)
         (insert (file-relative-name filename)))
        ((not (null args))
         (insert (expand-file-name filename)))
        (t
         (insert filename))))

(global-set-key "\C-c\C-i" 'my-insert-file-name)

;; Navigate outline mode smarter
(global-set-key (kbd "C-M-u") 'outline-up-heading)
(global-set-key (kbd "C-M-n") 'outline-forward-same-level)
(global-set-key (kbd "C-M-p") 'outline-backward-same-level)

;; Imenu-anywhere
(global-set-key (kbd "C-c g") 'imenu-anywhere)

;; Smex
(global-set-key (kbd "M-x") 'smex)

;; company-complete
(global-set-key [M-tab] 'company-complete)
