;; -*- lexical-binding: t -*-

(progn ;; Dashboard
  (require 'dashboard)
  (setq
   dashboard-set-init-info nil
   dashboard-set-footer nil
   dashboard-page-separator "\n\n"
   dashboard-center-content t
   dashboard-filter-agenda-entry 'dashboard-filter-agenda-by-todo
   dashboard-item-names '(("Agenda for the coming week:" . "Agenda:"))
   dashboard-items '((recents . 5) (agenda)))
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

  ;; Auto-refocus minibuffer on clicking the display buffer
  ;;
  ;; I prefer this to https://github.com/raxod502/selectrum/pull/586
  ;; as the behavior I'm looking for is for the buffer to be
  ;; completely unselectable, even if I don't click on something that
  ;; runs a command. It may be laggier but I haven't seen issues.
  (defun config-ui/selectrum-refocus-minibuffer ()
    (when (string= (buffer-name (window-buffer (selected-window))) selectrum--display-action-buffer)
      (select-window (active-minibuffer-window) nil)))
  (add-hook 'buffer-list-update-hook #'config-ui/selectrum-refocus-minibuffer)

  ;; On insert, set candidate to -1, easing selection of directories
  (defvar-local config-ui/selectrum--just-inserted-candidate nil)
  (defun config-ui/selectrum-smart-insert (&rest _)
    (setq-local config-ui/selectrum--just-inserted-candidate 't))
  (defun config-ui/selectrum--compute-current-candidate-index/:filter-return (result)
    (if (not (eq result 0))
	result
      (cond
       (config-ui/selectrum--just-inserted-candidate
	(setq-local config-ui/selectrum--just-inserted-candidate nil)
	-1)
       (t 0))))
  (add-hook 'selectrum-candidate-inserted-hook #'config-ui/selectrum-smart-insert)
  (advice-add #'selectrum--compute-current-candidate-index :filter-return
	      #'config-ui/selectrum--compute-current-candidate-index/:filter-return)

  (setq
   selectrum-fix-vertical-window-height 8
   marginalia-margin-threshold 170
   prescient-filter-method '(prefix))

  (selectrum-mode 1)
  (selectrum-prescient-mode 1)
  (marginalia-mode 1)
  (prescient-persist-mode 1))

(provide 'config-ui)
