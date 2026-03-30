(setq org-startup-with-inline-images t)

;;no query when executing code block
(setq org-confirm-babel-evaluate nil)

;;latex preview 
(use-package org-fragtog
  :ensure t
  :after org
  :hook (org-mode . org-fragtog-mode))  


(require 'ob-csharp)
;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
  (python . t)
  (C . t)
  (latex .t)
  (shell . t)
  (csharp . t)
  (emacs-lisp . t)))

(use-package url
  :ensure t
  :config
  (require 'url-handlers))


;;org modern
(use-package org-modern
  :ensure t
  :hook (after-init . (lambda ()
			(setq org-modern-hide-stars 'leading)
			(global-org-modern-mode t)))
  :config
  ;; 定义各级标题行字符
  (setq org-modern-star ["◉" "○" "✸" "✳" "◈" "◇" "✿" "❀" "✜"])
  (setq-default line-spacing 0.1)
  (setq org-modern-label-border 1)
  (setq org-modern-table-vectical 2)
  (setq org-modern-table-horizontal 0)

  ;; 复选框美化
  (setq org-modern-checkbox
	'((?X . #("▢✓" 0 2 (composition ((2)))))
	  (?- . #("▢–" 0 2 (composition ((2)))))
	  (?\s . #("▢" 0 1 (composition ((1)))))))
  ;; 列表符号美化
  (setq org-modern-list
	'((?- . "•")
	  (?+ . "◦")
	  (?* . "▹")))
  ;; 代码块左边加上一条竖边线
  (setq org-modern-block-fringe t)

  ;; 属性标签使用上述定义的符号，不由 org-modern 定义
  (setq org-modern-block-name nil)
  (setq org-modern-keyword nil)
  )(use-package org-modern
  :hook (org-mode . org-modern-mode))
;;- org modern

;;;;
(use-package hyperbole
  :ensure t
  :config
  (hyperbole-mode 1))  
;;;;



(provide 'org_mode_settings)
