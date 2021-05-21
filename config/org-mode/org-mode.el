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
   org-capture-templates
   '(("t" "Task" entry (file+headline org-default-notes-file "Tasks")
      "* TODO %^{Title}\n%u\n%?")
     ("T" "Task (Capture)" entry (file+headline org-default-notes-file "Tasks")
      "* TODO %^{Title}\n%u\n%a\n%?")
     ("i" "Idea" entry (file+headline org-default-notes-file "Ideas")
      "* %^{Title} \n%u\n%?")
     ("I" "Idea (Capture)" entry (file+headline org-default-notes-file "Ideas")
      "* %^{Title} \n%u\n%a\n%?"))))

(with-eval-after-load 'org
  (add-hook 'org-mode-hook 'org-indent-mode)
  (add-hook 'org-mode-hook 'auto-fill-mode)

  (setq org-agenda-files (list (locate-user-emacs-file "notes.org")))

  (defun config/org--insert-header-if-line-empty ()
    (when (or (bolp) (org-match-line "[:blank:]+"))
      (org-insert-heading)
      t))

  (add-hook 'org-tab-after-check-for-cycling-hook
	    'config/org--insert-header-if-line-empty)

  (defun config/org-delete-backwards-char/:before-until (N)
    (when (and (= N 1)
	       (org-point-at-end-of-empty-headline))
      (kill-whole-line)
      (forward-char -1)
      t))

  (advice-add 'org-delete-backward-char :before-until
	      'config/org-delete-backwards-char/:before-until)

  (defun config/org-cycle-promotion ()
    (interactive nil 'org-mode)
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
