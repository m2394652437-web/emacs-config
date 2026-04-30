(use-package fish-completion
  :if (executable-find "fish")
  :config
  (global-fish-completion-mode))

(use-package capf-autosuggest)
(add-hook 'eshell-mode-hook #'capf-autosuggest-mode)

(provide 'eshell-config)
