(use-package rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;(tab-bar-mode 1)
;(tab-bar-history-mode 1)
(pixel-scroll-mode 1)
(blink-cursor-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(ido-mode 1)
(global-visual-line-mode 1)
(setq inhibit-startup-screen t)

(set-frame-font "JetBrains Mono-13" nil t)


(global-hl-line-mode 1)

;;(use-package gruber-darker-theme)
;;(load-theme 'gruber-darker 1)
;;(load-theme 'whiteboard t)
(use-package modus-themes)
(load-theme 'modus-operandi t) 

(use-package golden-ratio
  :hook (after-init . golden-ratio-mode)
  :custom
  (golden-ratio-exclude-modes '(occur-mode)))

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)


(use-package solaire-mode
  :ensure t
  :config
  (solaire-global-mode +1)) 

;;;;mode line
;; 最小化配置
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



(use-package highlight-indent-guides
  :config
  (setq highlight-indent-guides-auto-enabled t )
  (setq highlight-indent-guides-method 'column)
  ;;(set-face-background 'highlight-indent-guides-odd-face "#16d4d4")
  ;;(set-face-background 'highlight-indent-guides-even-face "#ec90af")
 )
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)



(provide 'ui)
