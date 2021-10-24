;; -*- lexical-binding: t -*-

(require 'doom-opera-light-theme)

(load-theme 'doom-opera-light t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;;(set-face-attribute 'default nil
;;		    :font "Input Mono"
;;		    :weight 'light
;;		    :height 105)
;;
;;(set-face-attribute 'variable-pitch nil
;;		    :font "Input Serif"
;;		    :weight 'light
;;		    :height 105)

;;(add-hook 'prog-mode-hook
;;	  #'variable-pitch-mode)

(setq inhibit-startup-screen t)

(let ((display-table (make-display-table)))
  (set-display-table-slot display-table 'truncation 32)
  (setq-default standard-display-table display-table))

(provide 'config-quick-ui)
