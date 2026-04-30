(use-package async)
(dired-async-mode 1)
(async-bytecomp-package-mode 1)
(setq async-bytecomp-allowed-packages '(all))

(use-package with-editor)

(use-package transient
  :defer nil)  

(use-package clipetty
  :hook (after-init . global-clipetty-mode))

(use-package bind-key)

(use-package password-store
  :straight nil
  :defer nil
  :config
  (require 'password-store))

(use-package gcmh
  :config
  (setq gcmh-high-cons-threshold 33554432)
  (setq gcmh-idle-delay 15)
  (gcmh-mode 1))


;; (use-package golden-ratio
;;   :hook (after-init . golden-ratio-mode)
;;   :custom
;;   (golden-ratio-exclude-modes '(occur-mode))
;;   ;;(golden-ratio-exclude-buffer-names '("*SIDE*"))
;;   (golden-ratio-exclude-buffer-regexp '("*SIDE")))

(use-package consult
    :bind (("C-s" . consult-line)))

(use-package markdown-mode)

(use-package benchmark-init
  :init (benchmark-init/activate)
  :hook (after-init . benchmark-init/deactivate))

(use-package vertico
  :hook (after-init . vertico-mode))

(use-package orderless
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

(use-package embark)
(use-package wgrep)
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
