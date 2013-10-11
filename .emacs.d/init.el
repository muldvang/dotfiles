;; Write custom settings to custon.el
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Search for files in ~/.emacs.d
(setq load-path (append '("~/.emacs.d") load-path))

;; Load global settings
(load-library "fonts")
(load-library "behavior")
(load-library "buffers")
(load-library "bindings")
(load-library "gui")

(require 'package)
;; Add the original Emacs Lisp Package Archive
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
;; Add the user-contributed repositories
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/"))


;; Load other settings

;; Ido
(ido-mode 'both)

;; Flymake
(custom-set-variables
 '(help-at-pt-timer-delay 0)
 '(help-at-pt-display-when-idle '(flymake-overlay)))

;; Git-gutter+
(package-initialize)
(global-git-gutter+-mode t)

;; Auto-complete
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
;; (ac-config-default)

;; Company
(add-hook 'after-init-hook 'global-company-mode)

;; Outline minor mode
(outline-minor-mode 1)

;; Programming modes settings

;; LaTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

(setq TeX-PDF-mode t)

;; Lua
(add-hook 'lua-mode-hook 'flymake-lua-load)

;; CMake
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))

;; Python
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

;; C / C++
(setq-default c-basic-offset 4)
