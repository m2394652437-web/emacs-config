(use-package eshell-git-prompt
  :ensure t
  :after esh-mode)
(eshell-git-prompt-use-theme 'powerline)

(use-package rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(pixel-scroll-mode 1)
(blink-cursor-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(ido-mode 1)
(global-visual-line-mode 1)
(setq inhibit-startup-screen t)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)

;;font
(when (display-graphic-p)
  (add-hook 'window-setup-hook
	    (lambda ()
	      (set-face-attribute 'default nil :font "JetBrains Mono-11.5")      
	      (set-fontset-font t 'han "Maple Mono NF CN-12" nil 'prepend)      
	      )))
;;end fort

;;load theme
;;(use-package modus-themes)
;;(load-theme 'modus-operandi t) 
(load-theme 'deeper-blue t)
;;end load theme

(use-package solaire-mode
  :ensure t
  :config
  (solaire-global-mode +1)) 

;; ;;mode line
;; ;; spaceline 
;; ;;简单的占位
;; (setq-default header-line-format " Emacs")
;; (setq-default mode-line-format nil)

;; (use-package spaceline
;;   :ensure t
;;   :defer t
;;   :config
;;   (require 'spaceline-config)
;;   (setq spaceline-use-header-line t)
;;   (spaceline-spacemacs-theme)
;;   (setq spaceline-buffer-id-function 'buffer-file-path)
;;   (spaceline-toggle-buffer-id-on)
;;   (spaceline-toggle-buffer-size-on)
;;   (spaceline-toggle-major-mode-on)
;;   (spaceline-toggle-minor-modes-off)
;;   (setq-default header-line-format '((:eval (spaceline-ml-main))))
;;   (setq-default mode-line-format nil))

;; (add-hook 'after-init-hook
;; 	  (lambda ()
;; 	    (run-with-idle-timer 0.3 nil
;; 				 (lambda ()
;; 				   (require 'spaceline)				   
;; 				   ))))

(use-package nerd-icons
  :ensure t)

(use-package doom-modeline
  :ensure t  ;; 确保这一行存在，它会自动安装/加载包
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-highlight-modified-buffer-name nil)
  (setq doom-modeline-lsp-icon t)
  (setq doom-modeline-buffer-name t)
  (setq doom-modeline-minor-modes nil)
  (setq doom-modeline-enable-word-count t)
  ) 

(which-function-mode 1)

(provide 'ui)
