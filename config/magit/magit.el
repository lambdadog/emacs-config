;; -*- lexical-binding: t -*-

;; magit-status instead of magit so it takes over the current magit
;; window rather than opening a new one. I prefer this behavior
(define-key global-map (kbd "C-x g") 'magit-status)

;;; Forge
(setq forge-topic-list-limit '(60 . -5)
      forge-topic-list-order '(number . >))
(with-eval-after-load 'magit
  (require 'forge))

(provide 'config-magit)
