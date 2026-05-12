(use-package all-the-icons)
(use-package nerd-icons)

(use-package eshell-git-prompt
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
	      (set-face-attribute 'default nil :font "JetBrains Mono-10")      
	      (set-fontset-font t 'han "Maple Mono NF CN-10" nil 'prepend)      
	      )))
;;end fort

;;load theme
;;(load-theme 'deeper-blue t)
(load-theme 'modus-operandi t)
;;end load theme

(use-package solaire-mode  
  :config
  (solaire-global-mode +1)) 

;;mode line
(use-package nerd-icons)

(custom-set-faces
 '(mode-line ((t (
		  :box nil
		  :underline nil
		  :background unspecified
		  :foreground "#BDBDBD"
		  :weight bold))))

 '(mode-line-inactive ((t (
			   :box nil
			   :underline nil
			   :background unspecified
			   :foreground "#BDBDBD"
			   :weight bold))))

 '(mode-line-buffer-id ((t (
			    :foreground "violet"
			    :weight bold))))
 
 '(header-line ((t (
		    :background "#626262"
		    :foreground unspecified))))
 '(header-line-inactive ((t (
			     :background "#3232332"
			     :foreground unspecified)))))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-icon t)
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-buffer-modification-icon t)
  (setq doom-modeline-lsp-icon t)
  (setq doom-modeline-persp-icon t)
  (setq doom-modeline-check-icon t)
  (setq doom-modeline-check 'auto)

  (setq doom-modeline-vcs-icon t)
  (setq doom-modeline-vcs-display-function #'doom-modeline-vcs-name)
  (setq doom-modeline-vcs-state-faces-alist
      '((needs-update . (doom-modeline-warning bold))
        (removed . (doom-modeline-urgent bold))
        (conflict . (doom-modeline-urgent bold))
        (unregistered . (doom-modeline-urgent bold))))
  
  (setq doom-modeline-buffer-name t)
  (setq doom-modeline-project-name t)
  (setq doom-modeline-workspace-name t)
  (setq doom-modeline-persp-name t)
  (setq doom-modeline-unicode-number t)
  (setq doom-modeline-highlight-modified-buffer-name t)
  
  (setq doom-modeline-column-zero-based t)
  (setq doom-modeline-position-column-format '("C%c"))
  (setq doom-modeline-enable-buffer-position nil)
  
  (setq doom-modeline-minor-modes nil)
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
