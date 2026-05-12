`(autoload 'org-mode "org" nil t)
(autoload 'org-agenda "org-agenda" nil t)

;;org basic setting 
(with-eval-after-load 'org
  (setq org-startup-indented t)
  (setq org-startup-with-inline-images t)
  
  ;; arXiv link
  (org-link-set-parameters "arXiv"
			   :follow (lambda (id) (browse-url (format "https://arxiv.org/abs/%s" id)))
			   :export (lambda (id desc backend)
				     (cond
				      ((eq backend 'html)
				       (format "<a href=\"https://arxiv.org/abs/%s\">%s</a>" id (or desc id)))
				      ((eq backend 'latex)
				       (format "\\href{https://arxiv.org/abs/%s}{%s}" id (or desc id)))
				      (t (or desc id)))))

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (C . t)
     (latex . t)
     (shell . t)
     (emacs-lisp . t)))
  
  (setq org-latex-preview-process-default 'dvisvgm)
  (setq org-latex-preview-mode-display-live t)
  (setq org-latex-preview-mode-update-delay 0.25)
  
  ;; (custom-set-faces
  ;;  '(org-block ((t (:background "#f0f0f0"))))) 

  ;; (add-hook 'org-mode-hook
  ;; 	    (lambda ()
  ;; 	      (face-remap-add-relative 'default
  ;; 				       '(:background "#fdf6e3" :foreground "#657b83"))))
  
  (setq org-agenda-files
	'("~/Documents/My_files/todo.org"))

  (setq org-log-done 'time)

  )  

;;end org basic setting

(use-package org-ql
  :after org
  :demand t
  :config
  (require 'org-ql-search)
  (require 'org-ql-view))

(use-package htmlize
  :defer t)

;; url
(use-package url
  :defer t
  :config
  (require 'url-handlers))

;; org-modern
(use-package org-modern
  :after org
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star ["◉" "○" "✸" "✳" "◈" "◇" "✿" "❀" "✜"])
  (setq-default line-spacing 0.1)
  (setq org-modern-label-border 1)
  
  ;; table
  (setq org-modern-table-vertical 3)
  (setq org-modern-table-horizontal 0)
  (unless (display-graphic-p)
    (setq org-modern-table nil))
  ;; end table
  
  (setq org-modern-checkbox
	'((?X . #("▢✓" 0 2 (composition ((2)))))
	  (?- . #("▢–" 0 2 (composition ((2)))))
	  (?\s . #("▢" 0 1 (composition ((1)))))))

  (setq org-modern-list '((?- . "•") (?+ . "◦") (?* . "▹")))
  (setq org-modern-block-name t)
  (setq org-modern-keyword t)
  (setq org-src-fontify-natively t)
  )
;; end org modern

(use-package org-modern-indent
  :defer t
  :straight ( :host github
	      :repo "jdtsmith/org-modern-indent")
  :hook (org-mode . org-modern-indent-mode))

(use-package hyperbole
  :defer t
  :commands (hyperbole-mode))

(use-package org-roam
  :defer t
  :config
  (make-directory "~/Documents/My_files/notes" t)
  (setq org-roam-directory (file-truename "~/Documents/My_files/notes"))
  (org-roam-setup)
  (org-roam-db-autosync-mode)
  (setq org-id-method 'ts)
  )

(use-package org-roam-ui
  :defer t)

(use-package cdlatex
  :hook (org-mode . org-cdlatex-mode))

;;export typest
(use-package ox-typst
  :hook (org-mode . (lambda () (require 'ox-typst))))

;; (use-package olivetti
;;   :straight ( :host github
;; 	      :repo "rnkn/olivetti")
;;   :hook ((text-mode org-mode) . olivetti-mode)
;;   :config
;;   (add-hook 'org-mode-hook (lambda () (olivetti-set-width 100))))

(message "org-mode-settings.el loaded successfully!")
(provide 'org-mode-settings)
