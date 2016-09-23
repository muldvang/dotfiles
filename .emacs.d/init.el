(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(load "~/.emacs.d/init_interface.el")
(load "~/.emacs.d/init_behaviour.el")
(load "~/.emacs.d/init_key_bindings.el")
(load "~/.emacs.d/init_packages.el")

;; Open links in qutebrowser
(setq gnus-button-url 'browse-url-generic
      browse-url-generic-program "qutebrowser"
      browse-url-browser-function gnus-button-url)


(global-visual-line-mode)
(diminish 'visual-line-mode)


(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
(put 'narrow-to-region 'disabled nil)
