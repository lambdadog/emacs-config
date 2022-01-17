;; -*- lexical-binding: t -*-

(require 'config-ui)

(load (concat user-emacs-directory "secrets.el") 'noerror 'nomessage 'nosuffix)
(with-eval-after-load 'auth-source
  (setq auth-sources (list (concat user-emacs-directory "authinfo.gpg"))))

(require 'config-org-mode)
(require 'config-clojure)

(require 'config-magit)
(require 'config-mail)

(server-start)
(add-hook 'after-init-hook
	  (lambda () (select-frame-set-input-focus (selected-frame))))

(provide 'config-init)
