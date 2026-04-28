(autoload 'mu4e "mu4e" "Start mu4e" t)
(autoload 'mu4e-compose-new "mu4e" nil t)
(autoload 'mu4e-update-mail-and-index "mu4e" nil t)

(global-set-key (kbd "C-c m") 'mu4e)

(setq mu4e-get-mail-command "mbsync -a")
(setq mu4e-maildir "~/.mail")

"~/.mbsyncrc 
# QQ邮箱
IMAPAccount qq
Host imap.qq.com
User example@qq.com
Pass example
SSLType IMAPS
IMAPStore qq-remote
Account qq
MaildirStore qq-local
Path ~/.mail/qq/
Inbox ~/.mail/qq/INBOX
Channel qq
Master :qq-remote:
Slave :qq-local:
Patterns INBOX
Create Both
SyncState *
# Gmail
IMAPAccount gmail
Host imap.gmail.com
User example@gmail.com
Pass example
SSLType IMAPS
IMAPStore gmail-remote
Account gmail
MaildirStore gmail-local
Path ~/.mail/gmail/
Inbox ~/.mail/gmail/INBOX
Channel gmail
Master :gmail-remote:
Slave :gmail-local:
Patterns INBOX
Create Both
SyncState *
"

"
mu init --maildir=~/.mail --my-address=example@qq.com --my-address=example@gmail.com
"

(with-eval-after-load 'mu4e
  ;; 每 5 分钟自动检查新邮件
  (setq mu4e-update-interval 300)

  (setq message-send-mail-function 'smtpmail-send-it)
  (setq send-mail-function 'smtpmail-send-it)
  (setq message-sendmail-envelope-from 'header)

  (setq smtpmail-auth-credentials "~/.authinfo")  
  "
  in ~/.authinfo:
  machine smtp.qq.com login my-qq@qq.com password my-pwd port 465
  machine smtp.gmail.com login my-gmail@gmail.com my-pwd tkbpbiwtfkoeoztp port 587
  "

  (setq mu4e-index-lazy-check t)
  (setq mu4e-view-show-images t)
  (setq mu4e-view-prefer-html t)
  ;;(setq mu4e-attachment-dir "")
  
  (setq mu4e-contexts
    `(
      ;; QQ
      ,(make-mu4e-context
        :name "QQ"
        :match-func (lambda (msg)
                      (when msg
                        (string-match-p "/qq/" (mu4e-message-field msg :maildir))))
        :vars `((user-mail-address . ,my-qq-email)
                (user-full-name . ,my-name)
		(smtpmail-smtp-server . "smtp.qq.com")
		(smtpmail-smtp-service . 465)          
		(smtpmail-stream-type . 'ssl)          
                (mu4e-sent-folder . "/qq/Sent")
                (mu4e-drafts-folder . "/qq/Drafts")
                (mu4e-trash-folder . "/qq/Trash")
                (mu4e-refile-folder . "/qq/Archive")))
  
      ;; Gmail
      ,(make-mu4e-context
        :name "Gmail"
        :match-func (lambda (msg)
                      (when msg
                        (string-match-p "/gmail/" (mu4e-message-field msg :maildir))))
        :vars `((user-mail-address . ,my-gmail-email)
                (user-full-name . ,my-name)
		(smtpmail-smtp-server . "smtp.gmail.com")
		(smtpmail-smtp-service . 587)
		(smtpmail-stream-type . starttls)
                (mu4e-sent-folder . "/gmail/[Gmail].Sent Mail")
                (mu4e-drafts-folder . "/gmail/[Gmail].Drafts")
                (mu4e-trash-folder . "/gmail/[Gmail].Trash")
                (mu4e-refile-folder . "/gmail/Archive")))))

  ;; 切换上下文的策略
  (setq mu4e-context-policy 'ask-if-none)
  ;; 撰写邮件时的策略
  (setq mu4e-compose-context-policy 'ask))

(provide 'email)



