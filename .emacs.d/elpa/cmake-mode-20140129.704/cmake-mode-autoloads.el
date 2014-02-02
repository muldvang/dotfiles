;;; cmake-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "cmake-mode" "cmake-mode.el" (21230 18310 603583
;;;;;;  674000))
;;; Generated autoloads from cmake-mode.el

(autoload 'cmake-mode "cmake-mode" "\
Major mode for editing CMake listfiles.

\(fn)" t nil)

(autoload 'cmake-command-run "cmake-mode" "\
Runs the command cmake with the arguments specified.  The
optional argument topic will be appended to the argument list.

\(fn TYPE &optional TOPIC)" t nil)

(autoload 'cmake-help-list-commands "cmake-mode" "\
Prints out a list of the cmake commands.

\(fn)" t nil)

(autoload 'cmake-get-topic "cmake-mode" "\
Gets the topic from the minibuffer input.  The default is the word the cursor is on.

\(fn TYPE)" t nil)

(autoload 'cmake-help-command "cmake-mode" "\
Prints out the help message corresponding to the command the cursor is on.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))

(add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; cmake-mode-autoloads.el ends here
