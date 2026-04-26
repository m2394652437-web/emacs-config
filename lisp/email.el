(require 'mu4e)

;; 获取邮件的命令（使用 mbsync）
(setq mu4e-get-mail-command "mbsync -a")

;; 每 5 分钟自动检查新邮件
(setq mu4e-update-interval 300)

;; ============================================
;; mu4e 多邮箱上下文配置
;; ============================================

;; 设置邮件根目录
(setq mu4e-maildir "~/.mail")

;; 定义两个邮箱上下文
(setq mu4e-contexts
  `(
    ;; QQ 邮箱上下文
    ,(make-mu4e-context
      :name "QQ"
      :match-func (lambda (msg)
                    (when msg
                      (string-match-p "/qq/" (mu4e-message-field msg :maildir))))
      :vars '((user-mail-address . my-qq-email)
              (user-full-name . my-name)  ;; 改成你的名字
              (mu4e-sent-folder . "/qq/Sent")
              (mu4e-drafts-folder . "/qq/Drafts")
              (mu4e-trash-folder . "/qq/Trash")
              (mu4e-refile-folder . "/qq/Archive")))

    ;; Gmail 上下文
    ,(make-mu4e-context
      :name "Gmail"
      :match-func (lambda (msg)
                    (when msg
                      (string-match-p "/gmail/" (mu4e-message-field msg :maildir))))
      :vars '((user-mail-address . my-gmail-email)
              (user-full-name . my-name)  ;; 改成你的名字
              (mu4e-sent-folder . "/gmail/[Gmail].Sent Mail")
              (mu4e-drafts-folder . "/gmail/[Gmail].Drafts")
              (mu4e-trash-folder . "/gmail/[Gmail].Trash")
              (mu4e-refile-folder . "/gmail/Archive")))
   ))

;; 切换上下文的策略
;; 'ask-if-none: 如果没有匹配的上下文，就询问
(setq mu4e-context-policy 'ask-if-none)

;; 撰写邮件时的策略
;; 'ask: 每次写邮件都询问用哪个账户发送
(setq mu4e-compose-context-policy 'ask)

(provide 'email)
