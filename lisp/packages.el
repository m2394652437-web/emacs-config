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

(use-package gcmh
  :config
  (setq gcmh-high-cons-threshold 33554432)
  (setq gcmh-idle-delay 15)
  (gcmh-mode 1))

(use-package consult
  :bind (("C-s" . consult-line)))

(use-package drag-stuff
  :straight ( :host github
	      :repo "rejeep/drag-stuff.el"
	      :branch "master")
  :bind(("<M-up>". drag-stuff-up)
	("<M-down>". drag-stuff-down)))

;;ace window 
(use-package ace-window)
;;end ace window

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

(use-package vertico
  :hook (after-init . vertico-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless)))
(setq vertico-count 6) 
(setq vertico-fast t)

(use-package embark)
(use-package embark-consult
  :after embark)
(use-package wgrep)
(setq wgrep-auto-save-buffer t)

(use-package consult)

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

(use-package magit)
  ;; :defer nil
  ;; :straight ( :host github
  ;; 	      :repo "magit/magit"))

(provide 'packages)
