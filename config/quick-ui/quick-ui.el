;; -*- lexical-binding: t -*-

(require 'doom-sourcerer-theme)

(load-theme 'doom-sourcerer t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(set-face-attribute 'default nil
		    :font "Input Mono"
		    :weight 'light
		    :height 105)

(set-face-attribute 'variable-pitch nil
		    :font "Input Serif"
		    :weight 'light
		    :height 105)

(add-hook 'prog-mode-hook
	  #'variable-pitch-mode)

(setq inhibit-startup-screen t)

(provide 'config-quick-ui)
