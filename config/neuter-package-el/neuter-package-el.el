;; -*- lexical-binding: t -*-

(setq package-enable-at-startup nil)

(defun package--ensure-init-file/:override ())
(advice-add #'package--ensure-init-file :override
	    #'package--ensure-init-file/:override)
(defun package--save-selected-packages/:override (&optional _))
(advice-add #'package--save-selected-packages :override
	    #'package--save-selected-packages/:override)

(provide 'config-neuter-package-el)
