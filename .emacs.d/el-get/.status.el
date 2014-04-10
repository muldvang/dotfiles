((ac-math status "installed" recipe
	  (:name ac-math :type http :website "http://code.google.com/p/ac-math/" :description "This is an add-on which defines three ac-sources for the auto-complete package" :url "https://ac-math.googlecode.com/svn/trunk/ac-math.el"))
 (adaptive-wrap status "installed" recipe
		(:name adaptive-wrap :description "This package provides the `adaptive-wrap-prefix-mode' minor mode which sets\nthe wrap-prefix property on the fly so that single-long-line paragraphs get\nword-wrapped in a way similar to what you'd get with M-q using\nadaptive-fill-mode, but without actually changing the buffer's text." :website "http://elpa.gnu.org/packages/adaptive-wrap.html" :type elpa))
 (auctex status "installed" recipe
	 (:name auctex :website "http://www.gnu.org/software/auctex/" :description "AUCTeX is an extensible package for writing and formatting TeX files in GNU Emacs and XEmacs. It supports many different TeX macro packages, including AMS-TeX, LaTeX, Texinfo, ConTeXt, and docTeX (dtx files)." :type git :module "auctex" :url "git://git.savannah.gnu.org/auctex.git" :build
		`(("./autogen.sh")
		  ("./configure" "--without-texmf-dir" "--with-packagelispdir=$(pwd)" "--with-packagedatadir=$(pwd)" ,(cond
														       ((eq system-type 'darwin)
															"--with-lispdir=`pwd`")
														       (t ""))
		   ,(concat "--with-emacs=" el-get-emacs))
		  "make")
		:load-path
		("." "preview")
		:load
		("tex-site.el" "preview/preview-latex.el")
		:info "doc"))
 (auto-complete status "installed" recipe
		(:name auto-complete :website "https://github.com/auto-complete/auto-complete" :description "The most intelligent auto-completion extension." :type github :pkgname "auto-complete/auto-complete" :depends
		       (popup fuzzy)))
 (cl-lib status "installed" recipe
	 (:name cl-lib :builtin "24.3" :type elpa :description "Properly prefixed CL functions and macros" :url "http://elpa.gnu.org/packages/cl-lib.html"))
 (cmake-mode status "installed" recipe
	     (:name cmake-mode :website "http://www.itk.org/Wiki/CMake/Editors/Emacs" :description "Provides syntax highlighting and indentation for CMakeLists.txt and *.cmake source files." :type http :url "http://cmake.org/gitweb?p=cmake.git;a=blob_plain;hb=master;f=Auxiliary/cmake-mode.el"))
 (color-theme status "installed" recipe
	      (:name color-theme :description "An Emacs-Lisp package with more than 50 color themes for your use. For questions about color-theme" :website "http://www.nongnu.org/color-theme/" :type http-tar :options
		     ("xzf")
		     :url "http://download.savannah.gnu.org/releases/color-theme/color-theme-6.6.0.tar.gz" :load "color-theme.el" :features "color-theme" :post-init
		     (progn
		       (color-theme-initialize)
		       (setq color-theme-is-global t))))
 (color-theme-tangotango status "installed" recipe
			 (:name color-theme-tangotango :description "Another color theme based on the Tango palette." :type github :pkgname "juba/color-theme-tangotango" :depends color-theme :prepare
				(autoload 'color-theme-tangotango "color-theme-tangotango" "color-theme: tangotango" t)))
 (column-marker status "installed" recipe
		(:name column-marker :description "Highlight certain character columns" :type emacswiki :features column-marker))
 (dash status "installed" recipe
       (:name dash :description "A modern list api for Emacs. No 'cl required." :type github :pkgname "magnars/dash.el"))
 (deferred status "installed" recipe
   (:name deferred :description "Simple asynchronous functions for emacs lisp" :website "https://github.com/kiwanami/emacs-deferred" :type github :pkgname "kiwanami/emacs-deferred" :features "deferred"))
 (diff-hl status "installed" recipe
	  (:name diff-hl :type github :pkgname "dgutov/diff-hl" :description "Highlights uncommited changes in fringe" :prepare
		 (add-to-list 'custom-theme-load-path default-directory)))
 (dtrt-indent status "installed" recipe
	      (:name dtrt-indent :description "A minor mode that guesses the indentation offset originally used for creating source code files and transparently adjusts the corresponding settings in Emacs, making it more convenient to edit foreign files." :type github :pkgname "rrthomas/dtrt-indent" :features
		     (dtrt-indent)
		     :post-init
		     (dtrt-indent-mode 1)))
 (el-get status "installed" recipe
	 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "master" :pkgname "dimitri/el-get" :info "." :compile
		("el-get.*\\.el$" "methods/")
		:load "el-get.el"))
 (emacs-w3m status "installed" recipe
	    (:name emacs-w3m :description "A simple Emacs interface to w3m" :type cvs :website "http://emacs-w3m.namazu.org/" :module "emacs-w3m" :url ":pserver:anonymous@cvs.namazu.org:/storage/cvsroot" :build
		   `("autoconf"
		     ("./configure" ,(format "--with-emacs=%s" el-get-emacs))
		     "make")
		   :build/windows-nt
		   (("sh" "./autogen.sh")
		    ("sh" "./configure")
		    "make")
		   :info "doc"))
 (epl status "installed" recipe
      (:name epl :description "EPL provides a convenient high-level API for various package.el versions, and aims to overcome its most striking idiocies." :type github :pkgname "cask/epl"))
 (expand-region status "installed" recipe
		(:name expand-region :type github :pkgname "magnars/expand-region.el" :description "Expand region increases the selected region by semantic units. Just keep pressing the key until it selects what you want." :website "https://github.com/magnars/expand-region.el#readme" :features expand-region))
 (f status "installed" recipe
    (:name f :website "https://github.com/rejeep/f.el" :description "Modern API for working with files and directories in Emacs" :depends
	   (s dash)
	   :type github :pkgname "rejeep/f.el"))
 (fill-column-indicator status "installed" recipe
			(:name fill-column-indicator :type github :website "https://github.com/alpaker/Fill-Column-Indicator#readme" :description "An Emacs minor mode that graphically indicates the fill column." :pkgname "alpaker/Fill-Column-Indicator" :features fill-column-indicator))
 (flycheck status "installed" recipe
	   (:name flycheck :type github :pkgname "flycheck/flycheck" :description "On-the-fly syntax checking extension" :build
		  '(("makeinfo" "-o" "doc/flycheck.info" "doc/flycheck.texi"))
		  :info "./doc" :depends
		  (s dash cl-lib f pkg-info)))
 (flycheck-color-mode-line status "installed" recipe
			   (:name flycheck-color-mode-line :type github :pkgname "flycheck/flycheck-color-mode-line" :depends
				  (flycheck)))
 (fuzzy status "installed" recipe
	(:name fuzzy :website "https://github.com/auto-complete/fuzzy-el" :description "Fuzzy matching utilities for GNU Emacs" :type github :pkgname "auto-complete/fuzzy-el"))
 (haskell-mode status "installed" recipe
	       (:name haskell-mode :description "A Haskell editing mode" :type github :pkgname "haskell/haskell-mode" :info "." :build
		      `(("make" ,(format "EMACS=%s" el-get-emacs)
			 "all"))
		      :post-init
		      (progn
			(require 'haskell-mode-autoloads)
			(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
			(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation))))
 (hungry-delete status "installed" recipe
		(:name hungry-delete :description "Enables hungry deletion in all modes." :type github :pkgname "nflath/hungry-delete"))
 (idomenu status "installed" recipe
	  (:name idomenu :type emacswiki :description "imenu tag selection a la ido" :load-path "."))
 (irony-mode status "installed" recipe
	     (:name irony-mode :description "Emacs package using Clang for C & C++ completion, on-the-fly syntax checking and more!" :depends
		    (yasnippet auto-complete json)
		    :type github :branch "develop" :pkgname "Sarcasm/irony-mode" :build
		    (("mkdir -p build")
		     ("(cd build && cmake -DCMAKE_BUILD_TYPE=Release ..)")
		     ("make -j5 -C build install"))
		    :compile
		    ("elisp/" "elisp/irony/")
		    :load-path "elisp"))
 (json status "installed" recipe
       (:name json :description "JavaScript Object Notation parser / generator" :type http :builtin "23" :url "http://edward.oconnor.cx/elisp/json.el" :features json))
 (lua-mode status "installed" recipe
	   (:name lua-mode :description "A major-mode for editing Lua scripts" :website "https://github.com/immerrr/lua-mode" :type git :url "https://github.com/immerrr/lua-mode"))
 (package status "installed" recipe
	  (:name package :description "ELPA implementation (\"package.el\") from Emacs 24" :builtin "24" :type http :url "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el" :shallow nil :features package :post-init
		 (progn
		   (setq package-user-dir
			 (expand-file-name
			  (convert-standard-filename
			   (concat
			    (file-name-as-directory default-directory)
			    "elpa")))
			 package-directory-list
			 (list
			  (file-name-as-directory package-user-dir)
			  "/usr/share/emacs/site-lisp/elpa/"))
		   (make-directory package-user-dir t)
		   (unless
		       (boundp 'package-subdirectory-regexp)
		     (defconst package-subdirectory-regexp "^\\([^.].*\\)-\\([0-9]+\\(?:[.][0-9]+\\)*\\)$" "Regular expression matching the name of\n a package subdirectory. The first subexpression is the package\n name. The second subexpression is the version string."))
		   (setq package-archives
			 (bound-and-true-p package-archives))
		   (mapc
		    (lambda
		      (pa)
		      (add-to-list 'package-archives pa 'append))
		    '(("ELPA" . "http://tromey.com/elpa/")
		      ("gnu" . "http://elpa.gnu.org/packages/")
		      ("marmalade" . "http://marmalade-repo.org/packages/")
		      ("SC" . "http://joseito.republika.pl/sunrise-commander/"))))))
 (pkg-info status "installed" recipe
	   (:name pkg-info :description "Provide information about Emacs packages." :type github :pkgname "lunaryorn/pkg-info.el" :depends
		  (dash epl)))
 (pkgbuild-mode status "installed" recipe
		(:name pkgbuild-mode :description "Major mode for editing PKGBUILD files" :type github :pkgname "juergenhoetzel/pkgbuild-mode" :features pkgbuild-mode :post-init
		       (add-to-list 'auto-mode-alist
				    '("PKGBUILD$" . pkgbuild-mode))))
 (popup status "installed" recipe
	(:name popup :website "https://github.com/auto-complete/popup-el" :description "Visual Popup Interface Library for Emacs" :type github :submodule nil :pkgname "auto-complete/popup-el"))
 (popup-pos-tip status "installed" recipe
		(:name popup-pos-tip :auto-generated t :type emacswiki :description "pos-tip.el wrapper library for programs using popup.el" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/popup-pos-tip.el"))
 (pos-tip status "installed" recipe
	  (:name pos-tip :description "Show tooltip at point" :type emacswiki))
 (powerline status "installed" recipe
	    (:name powerline :website "https://github.com/milkypostman/powerline" :depends
		   (cl-lib)
		   :description "Powerline for Emacs" :type github :pkgname "milkypostman/powerline" :load-path "." :features powerline))
 (rainbow-delimiters status "installed" recipe
		     (:name rainbow-delimiters :website "https://github.com/jlr/rainbow-delimiters#readme" :description "Color nested parentheses, brackets, and braces according to their depth." :type github :pkgname "jlr/rainbow-delimiters"))
 (s status "installed" recipe
    (:name s :description "The long lost Emacs string manipulation library." :type github :pkgname "magnars/s.el" :features s))
 (smex status "installed" recipe
       (:name smex :description "M-x interface with Ido-style fuzzy matching." :type github :pkgname "nonsequitur/smex" :features smex :post-init
	      (smex-initialize)))
 (yasnippet status "installed" recipe
	    (:name yasnippet :website "https://github.com/capitaomorte/yasnippet.git" :description "YASnippet is a template system for Emacs." :type github :pkgname "capitaomorte/yasnippet" :compile "yasnippet.el" :submodule nil :build
		   (("git" "submodule" "update" "--init" "--" "snippets")))))
