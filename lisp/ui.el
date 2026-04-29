(use-package eshell-git-prompt
  :ensure t
  :after esh-mode)
(eshell-git-prompt-use-theme 'powerline)

(use-package rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(which-function-mode 1)
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

;;mode line
(use-package nerd-icons
  :ensure t)

(use-package telephone-line
  :ensure t)
(telephone-line-mode 1)

(custom-set-faces
 '(mode-line ((t (
		  :box nil
		  :underline nil
		  :background nil
		  :foreground "#BDBDBD"
		  :weight bold))))
 '(mode-line-inactive ((t (
			   :box nil
			   :underline nil
			   :background nil
			   :foreground "#BDBDBD"
			   :weight bold))))
 
 '(header-line ((t (
		    :background "#626262"
		    :foreground unspecified))))
 '(header-line-inactive ((t (
			     :background "#3232332"
			     :foreground unspecified)))))

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config

  (setq doom-modeline-icon t)
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-lsp-icon t)
  (setq doom-modeline-buffer-name t)
  (setq doom-modeline-highlight-modified-buffer-name t)
  (setq doom-modeline-minor-modes nil)

  (setq doom-modeline-selection-info t)
  (setq doom-modeline-enable-word-count nil)

  (setq doom-modeline-enable-buffer-position t)
  (setq doom-modeline-position-column-line-format '("%l:%c"))

  (setq doom-modeline-project-name t)

  (add-hook 'doom-modeline-mode-hook
            (lambda ()
              (setq-default header-line-format
                            '("%e" (:eval (doom-modeline-format--main))))
              (setq-default mode-line-format nil)
              )))
;;end mode line

(provide 'ui)
