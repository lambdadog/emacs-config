;; -*- lexical-binding: t -*-

(require 'config-ui)

(load (concat user-emacs-directory "secrets.el") 'noerror 'nomessage 'nosuffix)
(with-eval-after-load 'auth-source
  (setq auth-sources (list (concat user-emacs-directory "authinfo.gpg"))))

(editorconfig-mode 1)

;; (defun config//rescript-indent-relative ()
;;   (setq-local indent-line-function #'indent-relative))
;; (add-hook 'rescript-mode-hook #'config//rescript-indent-relative)

(setq tsc-dyn-dir (expand-file-name "tree-sitter/" user-emacs-directory))
(mkdir tsc-dyn-dir 'with-parents)

(setq tree-sitter-langs-grammar-dir (expand-file-name "tree-sitter-langs/" user-emacs-directory))
(mkdir (expand-file-name "bin/" tree-sitter-langs-grammar-dir) 'with-parents)

(require 'config-org-mode)
(require 'config-clojure)

(require 'config-magit)
(require 'config-mail)

(server-start)
(add-hook 'after-init-hook
	  (lambda () (select-frame-set-input-focus (selected-frame))))

(provide 'config-init)
