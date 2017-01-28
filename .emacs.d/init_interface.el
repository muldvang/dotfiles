;; Graphical stuff
(tool-bar-mode 0)
(menu-bar-mode 0)
(set-scroll-bar-mode nil)
(setq frame-title-format '("" "%b - Emacs"))

;; Frame stuff
(line-number-mode t)
(column-number-mode t)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq-default indicate-empty-lines t)

(setq-default mode-line-format
              '(
                (:propertize " %* ")
                (:propertize " %z ")
                (:propertize " %b " face (:weight bold))
                (:propertize " " face (:background "grey"))
                (:propertize mode-name face (:background "grey"))
                (:propertize minor-mode-alist face (:background "grey"))
                (:propertize " " face (:background "grey"))

                (:propertize " " display '(space :align-to (- right 18)))
                (:propertize " %l:%c ")
                (:propertize " %p ")
               ))

;; Buffer stuff
(load-theme 'adwaita t)
(set-face-attribute 'default nil :family "monospace" :height 95)
(blink-cursor-mode 0)
(setq visible-bell t)
(show-paren-mode t)
