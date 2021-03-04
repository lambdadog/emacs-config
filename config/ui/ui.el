;; -*- lexical-binding: t -*-

(progn ;; Dashboard
  (require 'dashboard)
  (setq
   dashboard-set-init-info nil
   dashboard-set-footer nil
   dashboard-page-separator "\n\n"
   dashboard-center-content t)
  (dashboard-setup-startup-hook))

(provide 'config-ui)
