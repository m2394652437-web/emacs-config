(use-package eshell-git-prompt
:ensure t
:after esh-mode)
(eshell-git-prompt-use-theme 'powerline)

(use-package rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;(tab-bar-mode 1)
;(tab-bar-history-mode 1)

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

(set-frame-font "JetBrains Mono-11.5" nil t)

;;load theme

;; (use-package modus-themes)
;; (load-theme 'modus-operandi t) 
(load-theme 'deeper-blue t)

;;end load theme

(use-package solaire-mode
  :ensure t
  :config
  (solaire-global-mode +1)) 

;; (use-package indent-bars
;;   :ensure t
;;   :hook (prog-mode . indent-bars-mode)
;;   :config
;;   (setq indent-bars-width-follows-indent-p t)
;;     (setq indent-bars-pattern nil           ; 重要：取消逐字符模式
;;         indent-bars-odd-fringe-pattern nil
;;         indent-bars-even-fringe-pattern nil))

;;;;mode line
;; spaceline 顶部显示配置
(use-package spaceline)
(require 'spaceline-config)
(setq spaceline-use-header-line t)
;(setq redisplay-dont-pause t)
;(setq redisplay-skip-fontification-on-input nil)
(spaceline-spacemacs-theme)
(setq spaceline-buffer-id-function 'buffer-file-path)
(spaceline-toggle-buffer-id-on)
(spaceline-toggle-buffer-size-on)
(spaceline-toggle-major-mode-on)
(spaceline-toggle-minor-modes-off)
(setq-default header-line-format
              '((:eval (spaceline-ml-main))))
(setq-default mode-line-format nil)

(provide 'ui)
