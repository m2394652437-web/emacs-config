(use-package paradox)
(paradox-enable)

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

(use-package drag-stuff
  :bind(("<M-up>". drag-stuff-up)
	("<M-down>". drag-stuff-down)))

(use-package restart-emacs)

(use-package flycheck
  :hook(after-init . global-flycheck-mode))

;better buffer control

;;ace window 
(use-package ace-window 
  :bind (("s-/ " . 'ace-window)))

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


(progn
  (setq consult-locate-args (encode-coding-string "es.exe -i -p -r" 'gbk))
  (add-to-list 'process-coding-system-alist '("es" gbk . gbk))
  )
(eval-after-load 'consult
  (progn
    (setq
     consult-narrow-key "<"
     consult-line-numbers-widen t
     consult-async-min-input 2
     consult-async-refresh-delay  0.15
     consult-async-input-throttle 0.2
     consult-async-input-debounce 0.1)
    ))



(provide 'packages)
