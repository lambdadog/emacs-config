;; -*- lexical-binding: t -*-

;; Reset all vars we're using for config
(setenv "XDG_CONFIG_HOME" (getenv "NIX_STORED_XDG_CONFIG_HOME"))
(setenv "NIX_STORED_XDG_CONFIG_HOME")

;; Set user-emacs-directory to a mutable location
;; TODO: move this out of /tmp
(mkdir "/tmp/emacs")
(setq user-emacs-directory "/tmp/emacs") 
