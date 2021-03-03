;; -*- lexical-binding: t -*-

;; Reset all vars we're using for config
(setenv "XDG_CONFIG_HOME" (getenv "NIX_STORED_XDG_CONFIG_HOME"))
(setenv "NIX_STORED_XDG_CONFIG_HOME")

;; Set user-emacs-directory to a mutable location
;; TODO: move this out of /tmp
(mkdir "/tmp/emacs" t)
(setq user-emacs-directory "/tmp/emacs") 

;; load autoloads
(dolist (dir load-path)
  (dolist (autoload (file-expand-wildcards
		     (expand-file-name "*-autoloads.el" dir)
                     t))
    (load autoload nil t t)))
