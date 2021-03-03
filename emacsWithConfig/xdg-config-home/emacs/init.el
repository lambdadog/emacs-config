;; -*- lexical-binding: t -*-

;; init.el isn't mutable, so this is necessary
;;
;; we set user-emacs-directory in `early-init.el` so it's safe to use
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;; load our actual config
(load-library (getenv "NIX_EMACS_INIT_PACKAGE"))
(setenv "NIX_EMACS_INIT_PACKAGE")
