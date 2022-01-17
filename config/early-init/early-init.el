;; -*- lexical-binding: t -*-

;; Hide UI mess
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Hide truncation symbol
(let ((display-table (make-display-table)))
  (set-display-table-slot display-table 'truncation 32)
  (setq-default standard-display-table display-table))

(setq inhibit-startup-screen t)

;; Kill package.el
;;
;; https://github.com/raxod502/straight.el/blob/af5437f2afd00936c883124d6d3098721c2d306c/straight.el#L6358
(setq package-enable-at-startup nil)

(defun package--ensure-init-file/:override ())
(advice-add #'package--ensure-init-file :override
	    #'package--ensure-init-file/:override)
(defun package--save-selected-packages/:override (&optional _))
(advice-add #'package--save-selected-packages :override
	    #'package--save-selected-packages/:override)

;; Load emacsWithPackages provided autoloads and packages
(require 'info)
(info-initialize)

(dolist (dir load-path)
  ;; autoloads
  (dolist (autoload (file-expand-wildcards
		     (expand-file-name "*-autoloads.el" dir)
                     t))
    (load autoload nil t t))
  ;; manuals
  (when (file-expand-wildcards (expand-file-name "*.info" dir) t)
    (add-to-list 'Info-directory-list dir)))

;; Load theme
(require 'doom-opera-light-theme)
(load-theme 'doom-opera-light t)

(provide 'config-early-init)
