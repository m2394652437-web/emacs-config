(use-package clipetty
  :ensure t
  :hook (after-init . global-clipetty-mode))

(use-package bind-key
  :ensure t)

(use-package password-store)
(require 'password-store)

(use-package gcmh
  :config
  (setq gcmh-high-cons-threshold 33554432)
  (setq gcmh-idle-delay 15))
(gcmh-mode 1)

(use-package paradox)
(paradox-enable)

(use-package golden-ratio
  :hook (after-init . golden-ratio-mode)
  :custom
  (golden-ratio-exclude-modes '(occur-mode)))

(use-package consult
  :ensure t                   
  :bind (("C-s" . consult-line)))

(use-package markdown-mode
  :ensure t)

(use-package benchmark-init
  :init (benchmark-init/activate)
  :hook (after-init . benchmark-init/deactivate))

(use-package projectile)

(use-package vertico
  :ensure t
  :hook (after-init . vertico-mode))
(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless)))
(setq vertico-count 6) 
(setq vertico-fast t)

(use-package drag-stuff
  :bind(("<M-up>". drag-stuff-up)
	("<M-down>". drag-stuff-down)))

(use-package restart-emacs)

;; (use-package flycheck
;;   :hook(after-init . global-flycheck-mode))

;better buffer control

;;ace window 
(use-package ace-window)
;;end ace window

(package-install 'embark-consult)
(package-install 'wgrep)
(setq wgrep-auto-save-buffer t)

(eval-after-load
    'consult
  '(eval-after-load
       'embark
     '(progn
        (require 'embark-consult)
        (add-hook
         'embark-collect-mode-hook
         #'consult-preview-at-point-mode))))

(define-key minibuffer-local-map (kbd "C-c C-e") 'embark-export-write)

(provide 'packages)
