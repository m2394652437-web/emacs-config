;;(setq gc-cons-threshold 33554432) 
(setq undo-auto-current-boundary-timer nil) 

(setq initial-scratch-message     "夫君子之行，静以修身，俭以养德。非澹泊无以明志，非宁静无以致远。
夫学须静也，才须学也，非学无以广才，非志无以成学。淫慢则不能励精，险躁则不能治性。
年与时驰，意与日去，遂成枯落，多不接世，悲守穷庐，将复何及！
")


(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))


;; (setq package-archives '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;                          ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
;;                          ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

;; ;;"melpa"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa"
;; ;;"melpa" . "https://melpa.org/packages/"

(setq package-check-signature nil)
 
(unless (bound-and-true-p package--initialized)
 (package-initialize))

(unless package-archive-contents
  (package-refresh-contents))


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)      
(setq use-package-always-defer t)     
(setq use-package-always-demand nil)
(setq use-package-expand-minimally t)
(setq use-package-verbose t)


(require 'use-package)

(setenv "PYTHON_BASIC_REPL" "1")



(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8)

(setq gc-cons-threshold most-positive-fixnum)


;;用于处理emacs PATH与shell的PATH不同的问题
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(provide 'startup)

