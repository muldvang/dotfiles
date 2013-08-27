;;; git-gutter+-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (git-gutter+-stage-and-commit git-gutter+-commit
;;;;;;  git-gutter+-stage-hunks git-gutter+-previous-hunk git-gutter+-next-hunk
;;;;;;  git-gutter+-popup-hunk git-gutter+-revert-hunk global-git-gutter+-mode
;;;;;;  git-gutter+-mode) "git-gutter+" "git-gutter+.el" (21020 43333
;;;;;;  283618 640000))
;;; Generated autoloads from git-gutter+.el

(autoload 'git-gutter+-mode "git-gutter+" "\
Git-Gutter mode

\(fn &optional ARG)" t nil)

(defvar global-git-gutter+-mode nil "\
Non-nil if Global-Git-Gutter+ mode is enabled.
See the command `global-git-gutter+-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-git-gutter+-mode'.")

(custom-autoload 'global-git-gutter+-mode "git-gutter+" nil)

(autoload 'global-git-gutter+-mode "git-gutter+" "\
Toggle Global-Git-Gutter+ mode on or off.
With a prefix argument ARG, enable Global-Git-Gutter+ mode if ARG is
positive, and disable it otherwise.  If called from Lisp, enable
the mode if ARG is omitted or nil, and toggle it if ARG is `toggle'.
\\{global-git-gutter+-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'git-gutter+-revert-hunk "git-gutter+" "\
Revert current hunk.

\(fn)" t nil)

(autoload 'git-gutter+-popup-hunk "git-gutter+" "\
popup current diff hunk

\(fn &optional DIFFINFO)" t nil)

(autoload 'git-gutter+-next-hunk "git-gutter+" "\
Move to next diff hunk

\(fn ARG)" t nil)

(autoload 'git-gutter+-previous-hunk "git-gutter+" "\
Move to previous diff hunk

\(fn ARG)" t nil)

(autoload 'git-gutter+-stage-hunks "git-gutter+" "\


\(fn)" t nil)

(autoload 'git-gutter+-commit "git-gutter+" "\


\(fn)" t nil)

(autoload 'git-gutter+-stage-and-commit "git-gutter+" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("git-gutter+-pkg.el") (21020 43333 292343
;;;;;;  7000))

;;;***

(provide 'git-gutter+-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; git-gutter+-autoloads.el ends here
