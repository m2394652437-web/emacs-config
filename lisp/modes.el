(require 'package
	 :defer t)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))

(use-package glsl-mode)

;; (add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
;; (add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))

;; (add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-ts-mode))
;; (add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-ts-mode))
;; (setq treesit-font-lock-level 4)

(provide 'modes)
