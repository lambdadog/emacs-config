;; -*- lexical-binding: t -*-

(progn ;; Dashboard
  (require 'dashboard)
  (setq
   dashboard-set-init-info nil
   dashboard-set-footer nil
   dashboard-page-separator "\n\n"
   dashboard-center-content t)
  (dashboard-setup-startup-hook))

(progn ;; Selectrum
  (require 'selectrum)
  (require 'marginalia)
  (require 'selectrum-prescient)

  (setq selectrum-display-action
	'(display-buffer-in-side-window
	  (side . bottom)
	  (slot . -1)))
  (add-hook 'selectrum-display-action-hook
	    (lambda ()
	      (setq
	       mode-line-format nil
	       truncate-lines t)))

  (setq
   selectrum-fix-vertical-window-height 8
   marginalia-margin-threshold 170
   prescient-filter-method '(prefix))

  (selectrum-mode 1)
  (selectrum-prescient-mode 1)
  (marginalia-mode 1)
  (prescient-persist-mode 1))

(provide 'config-ui)
