(autoload 'org-mode "org" nil t)
(autoload 'org-agenda "org-agenda" nil t)

;; org 加载后才执行的配置
(with-eval-after-load 'org
  ;; 基础设置
  (setq org-startup-with-inline-images t)
  
  ;; arXiv 链接
  (org-link-set-parameters "arXiv"
    :follow (lambda (id) (browse-url (format "https://arxiv.org/abs/%s" id)))
    :export (lambda (id desc backend)
              (cond
               ((eq backend 'html) 
                (format "<a href=\"https://arxiv.org/abs/%s\">%s</a>" id (or desc id)))
               ((eq backend 'latex)
                (format "\\href{https://arxiv.org/abs/%s}{%s}" id (or desc id)))
               (t (or desc id))))))

;; org-fragtog
(use-package org-fragtog
  :ensure t
  :after org
  :hook (org-mode . (lambda ()
                      (when (display-graphic-p)
                        (org-fragtog-mode 1)))))

(use-package htmlize
  :defer t)

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (C . t)
     (latex . t)
     (shell . t)
     (emacs-lisp . t))))

;; url 处理
(use-package url
  :defer t
  :config
  (require 'url-handlers))

;; org-modern
(use-package org-modern
  :ensure t
  :after org  
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star ["◉" "○" "✸" "✳" "◈" "◇" "✿" "❀" "✜"])
  (setq-default line-spacing 0.1)
  (setq org-modern-label-border 1)
  (setq org-modern-table-vertical 2)
  (setq org-modern-table-horizontal 0)
  (setq org-modern-checkbox
        '((?X . #("▢✓" 0 2 (composition ((2)))))
          (?- . #("▢–" 0 2 (composition ((2)))))
          (?\s . #("▢" 0 1 (composition ((1)))))))
  (setq org-modern-list '((?- . "•") (?+ . "◦") (?* . "▹")))
  (setq org-modern-block-fringe t)
  (setq org-modern-block-name nil)
  (setq org-modern-keyword nil))

(use-package hyperbole
  :ensure t
  :defer t 
  :commands (hyperbole-mode))

(message "org_mode_settings.el loaded successfully!")
(provide 'org_mode_settings)
