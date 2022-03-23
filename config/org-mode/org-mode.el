;; -*- lexical-binding: t -*-

(define-key global-map (kbd "C-c c") 'org-capture)
(define-key global-map (kbd "C-c a") 'org-agenda)
(define-key global-map (kbd "C-c s") 'org-store-link)

(with-eval-after-load 'dashboard
  (setq dashboard-banner-logo-title
	(substitute-command-keys "Remember to use `\\[org-capture]' (org-capture) \
and `\\[org-agenda]' (org-agenda)!")))

(with-eval-after-load 'org-capture
  (setq
   org-default-notes-file (locate-user-emacs-file "notes.org")
   org-capture-bookmark nil
   org-capture-templates ;; TODO: Add structure note & task templates
   '(("n" "Note" entry (file+headline org-default-notes-file "Notes")
      "* %?\n%u\n%a\n%i\n")
     ("N" "Note (Quote)" entry (file+headline org-default-notes-file "Notes")
      "* %?\n%u\n%a\n#+BEGIN_QUOTE\n%i\n#+END_QUOTE\n"))))

(with-eval-after-load 'org
  (require 'ox-bb)

  (add-hook 'org-mode-hook 'org-indent-mode)
  (add-hook 'org-mode-hook 'auto-fill-mode)

  (setq org-agenda-files (list (locate-user-emacs-file "notes.org")))

  ;; If at the begenning of an empty line, tab creates a new heading
  ;; at the level of the previous.
  (progn
    (defun config/org--insert-header-if-line-empty ()
      (when (or (bolp) (org-match-line "[:blank:]+"))
	(org-insert-heading)
	t))

    (add-hook 'org-tab-after-check-for-cycling-hook
	      'config/org--insert-header-if-line-empty))

  ;; If at end of empty headline, backspace deletes the whole
  ;; heading. Essentially the inverse of using tab to create the
  ;; heading.
  (progn
    (defun config/org-delete-backwards-char/:before-until (N)
      (when (and (= N 1)
		 (org-point-at-end-of-empty-headline))
	(delete-region (line-beginning-position) (line-end-position))
	t))

    (advice-add 'org-delete-backward-char :before-until
		'config/org-delete-backwards-char/:before-until))

  ;; Shift-tab cycles promotion of an empty heading
  (progn
    (defun config/org-cycle-promotion ()
      (interactive)
      (let ((org-adapt-indentation nil))
	(when (org-point-at-end-of-empty-headline)
          (if (= (org-current-level) (org-get-previous-line-level))
	      (let ((org-adapt-indentation nil))
		(org-do-promote))
	    (call-interactively 'org-cycle-level)))))

    (defun config/org-shifttab/:before-until (&rest _)
      (when (org-point-at-end-of-empty-headline)
	(call-interactively 'config/org-cycle-promotion)
	t))

    (advice-add 'org-shifttab :before-until
		'config/org-shifttab/:before-until))

  ;; Most export methods don't care, but some do.
  (progn
    (defun config/org--unfill-before-export (&rest _)
      (let ((fill-column (point-max)))
	(fill-region (point) (point-max))))

    (add-hook 'org-export-before-processing-hook
	      'config/org--unfill-before-export)))

(with-eval-after-load 'org-src
  ;; `I prefer magit-commit`-like behavior for this
  (setq org-edit-src-persistent-message nil)
  (add-hook 'org-src-mode-hook
	    (lambda ()
	      (message
	       (substitute-command-keys
		(if org-src--allow-write-back
		    "Edit, then exit with `\\[org-edit-src-exit]' or abort with \
`\\[org-edit-src-abort]'"
		  "Exit with `\\[org-edit-src-exit]' or abort with \
`\\[org-edit-src-abort]'")))))

  ;; More `magit-commit`-like behavior
  (define-key org-src-mode-map (kbd "C-c '") nil)
  (define-key org-src-mode-map (kbd "C-c C-c") 'org-edit-src-exit))

(provide 'config-org-mode)
