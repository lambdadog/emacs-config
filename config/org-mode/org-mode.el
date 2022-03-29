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
   '(("t" "Task" entry (file+headline org-default-notes-file "Tasks")
      "* TODO \n%u\n%a\n%?\n")
     ("n" "Note" entry (file+headline org-default-notes-file "Notes")
      "* \n%u\n%a\n%?\n")
     ("N" "Note (Quote)" entry (file+headline org-default-notes-file "Notes")
      "* %?\n%u\n%a\n#+BEGIN_QUOTE\n%i\n#+END_QUOTE\n")
     ("s" "Structure Note" entry (file+headline org-default-notes-file "Structure")
      "* %?\n%u\n - %a\n"))))

(with-eval-after-load 'org
  (require 'ox-bb)

  (add-hook 'org-mode-hook 'org-indent-mode)
  (add-hook 'org-mode-hook 'auto-fill-mode)

  (setq org-agenda-files (list (locate-user-emacs-file "notes.org")))

  (setq org-startup-with-inline-images t
	org-image-actual-width '(500))

  (defun config//select-org-heading ()
    (let* ((headings-alist
	    (org-map-entries
	     (lambda ()
	       (let* ((props (nth 1 (org-element-context)))
		      (heading-text-fontified
		       (save-mark-and-excursion
			 (save-restriction
			   (widen)
			   (let* ((begin (goto-char (plist-get props :begin)))
				  (end   (progn (end-of-line) (point))))
			     (font-lock-ensure begin end)
			     (buffer-substring begin end))))))
		 `(,heading-text-fontified . ,props)))))
	   (headings (mapcar #'car headings-alist))
	   (completion-function
	    (lambda (string pred action)
	      (cond
	       ((eq action 'metadata)
		`(metadata
		  (display-sort-function . ,#'identity)))
	       (t (complete-with-action action headings string pred)))))
	   (completion-result (completing-read "Heading: " completion-function)))
      (cdr (assoc completion-result headings-alist #'string=))))

  (defun config/org-link-heading-in-file ()
    (interactive)
    (let* ((props (config//select-org-heading))
	   (link
	    (save-mark-and-excursion
	      (save-restriction
		(goto-char (plist-get props :begin))
		(org-store-link nil nil)))))
      (insert link)))

  ;; Create l prefix
  (define-key org-mode-map (kbd "C-c C-o"  ) nil)
  (define-key org-mode-map (kbd "C-c l o"  ) 'org-open-at-point)
  (define-key org-mode-map (kbd "C-c l RET") 'org-open-at-point)
  (define-key org-mode-map (kbd "C-c C-l"  ) nil)
  (define-key org-mode-map (kbd "C-c l i"  ) 'org-insert-link)
  (define-key org-mode-map (kbd "C-c l l"  ) 'config/org-link-heading-in-file)
  ;;(define-key org-mode-map (kbd "C-c l I") 'config/org-backlink/org-insert-link-with-backlink)
  ;;(define-key org-mode-map (kbd "C-c l b") 'config/org-backlink/org-insert-backlink)

  ;; (progn
  ;;   (defun config/org-backlink//link-is-to-org-heading ()
  ;;     ;; test if link is to org heading
  ;;     )
  ;;   (defun config/org-backlink/insert-link-with-backlink ()
  ;;     (interactive)
  ;;     (call-interactively #'org-insert-link)
  ;;     (save-excursion
  ;; 	(backward-char) ;; to actually put your cursor on the link
  ;; 	(config/org-insert-backlink)))
  ;;   (defun config/org-backlink/org-insert-backlink ()
  ;;     (interactive)
  ;;     (when (config/org-backlink//link-is-to-org-heading)
  ;; 	(save-mark-and-excursion
  ;;
  ;;     ))

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
