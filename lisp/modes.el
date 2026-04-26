(require 'package
 :defer t)

 (add-to-list 'package-archives
 '("melpa" . "http://melpa.org/packages/"))

 (use-package glsl-mode)

 ;; (add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
 ;; (add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))

 (provide 'modes)
