;; -*- lexical-binding: t -*-
(require 'sendmail)
(require 'smtpmail)

(if (not (and (boundp 'secret--user-mail-address)
	      (stringp secret--user-mail-address)))
    (display-warning 'initialization "\


Failed to set `user-mail-address'. Does your secrets.el file
exist and does it set `secret--user-mail-address'?
" :warning)
  (setq user-mail-address secret--user-mail-address))

(setq send-mail-function    'smtpmail-send-it
      smtpmail-smtp-server  "smtp.migadu.com"
      smtpmail-local-domain "pea.sh"
      smtpmail-stream-type  'ssl
      smtpmail-smtp-service 465)

(provide 'config-mail)
