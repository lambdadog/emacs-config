;; -*- lexical-binding: t -*-

;; Reset all vars we're using for config
(setenv "XDG_CONFIG_HOME" (getenv "NIX_STORED_XDG_CONFIG_HOME"))
(setenv "NIX_STORED_XDG_CONFIG_HOME")

;; Set user-emacs-directory to a mutable location
(let ((emacs-directory (expand-file-name "~/.local/share/emacs/")))
  (mkdir emacs-directory t)
  (setq user-emacs-directory emacs-directory))

;; load autoloads
(dolist (dir load-path)
  (dolist (autoload (file-expand-wildcards
		     (expand-file-name "*-autoloads.el" dir)
                     t))
    (load autoload nil t t)))
