;; -*- lexical-binding: t -*-

(require 'config-quick-ui)
(require 'config-neuter-package-el)
(require 'config-ui)

(require 'config-org-mode)
(require 'config-magit)

(server-start)
(add-hook 'after-init-hook
	  (lambda () (select-frame-set-input-focus (selected-frame))))

(provide 'config-init)
