;;用dired时省略emcas自动备份文件
(add-hook 'dired-mode-hook 'dired-omit-mode)
(add-hook 'dired-mode-hook 'auto-revert-mode)

(use-package treemacs
  :config
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-git-mode 'extended)
  (treemacs-filewatch-mode t))
(use-package treemacs-projectile)
(use-package treemacs-magit)


(provide 'file_management)
