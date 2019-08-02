;; Graphical stuff
(tool-bar-mode 0)
(menu-bar-mode 0)
(set-scroll-bar-mode nil)
(setq frame-title-format "%b - Emacs")
(setq icon-title-format "%b - Emacs")

;; Frame stuff
(line-number-mode t)
(column-number-mode t)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq-default indicate-empty-lines t)


(setq-default mode-line-format
              '(
                (:propertize " %* ")
                (:eval
                 (when (eql buffer-read-only t)
                   (propertize (all-the-icons-faicon "lock")
                               'face `(:family ,(all-the-icons-faicon-family)
                                               :height 1.2))))
                ;; (:propertize " %z ")
                (:propertize " %b " face (:weight bold))
                ;; (:propertize " " face (:background "grey"))
                (:eval (propertize (all-the-icons-icon-for-buffer) 'help-echo (format "Major-mode: ` %s'" major-mode)
                                   'display '(raise 0.0)
                                   'face `(;; :background "grey"
                                           :height 1.2 :family ,(all-the-icons-icon-family-for-buffer))))
                ;; (:propertize " " face (:background "grey"))
                ;; (:propertize mode-name face (:background "grey"))
                ;; (:propertize minor-mode-alist face (:background "grey"))
                ;; (:propertize " " face (:background "grey"))

                (:propertize " " display '(space :align-to (- right 11)))
                (:propertize " %l:%c ")
                ;; (:propertize " %p ")
                ))

(set-face-attribute 'mode-line nil :background "#EDEDED")

;; Buffer stuff
(load-theme 'adwaita t)
(set-face-attribute 'default nil :background "white")

(set-face-attribute 'default nil :family "input mono light" :height 95)
;; (add-to-list 'default-frame-alist
;;              '(font . "Input Mono Light 9.5"))
(blink-cursor-mode 0)
(setq visible-bell t)
(show-paren-mode t)
