(setq mouse-wheel-scroll-amount '(5))

(global-set-key (kbd "C-V") 'yank)
(global-set-key (kbd "C-Z") 'undo)
(global-set-key (kbd "C-k") 'kill-line)

(defalias 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "<f1>") 'dired)

(global-set-key 
 (kbd "<f2>") 
 (lambda ()
   (interactive)
   (let ((display-buffer-overriding-action
          '((display-buffer-pop-up-frame . nil))))
     (dired "~/.emacs.d/lisp/"))))

(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "<f7>") 'kmacro-start-macro-or-insert-counter)

;;password store
(bind-key "C-P" 'password-store-copy)
;;end password store

;;eshell
(global-set-key (kbd "s-s") 'eshell)
;;end eshell

;;input method
(global-set-key (kbd "C-SPC") 'toggle-input-method)
;;end input method

;;kill then yank
(defun my-kill-then-yank ()
  (interactive)
  (kill-whole-line)
  (yank))
(global-set-key (kbd "M-k") 'my-kill-then-yank)
;;end kill then yank

(global-set-key (kbd "M-]") 'ff-find-other-file)

(defun open-init-file()
  (interactive)
  (find-file-other-frame "~/.emacs.d/init.el"))
	
(defun hotkeys()
  (interactive)
  (find-file "~/.emacs.d/lisp/init-keybindings.el"))

;;treemacs
(global-set-key (kbd "s-a") 'treemacs)
;;end treemacs

;;org-mode
(global-set-key (kbd "M-s ") 'org-redisplay-inline-images)
(define-key minibuffer-local-map (kbd "C-c C-e") 'embark-export-write)
;;end org-mode

(provide 'mouse&keybindings)
