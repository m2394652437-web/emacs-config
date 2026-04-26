(use-package fish-completion
  :ensure t
  :if (executable-find "fish")
  :config
  (global-fish-completion-mode))

(provide 'eshell-config)
