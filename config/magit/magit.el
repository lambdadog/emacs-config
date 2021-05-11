;; -*- lexical-binding: t -*-

;; magit-status instead of magit so it takes over the current magit
;; window rather than opening a new one. I prefer this behavior
(with-eval-after-load 'magit
  (define-key global-map (kbd "C-x g") 'magit-status))

(provide 'config-magit)
