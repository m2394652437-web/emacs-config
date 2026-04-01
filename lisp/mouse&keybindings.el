(global-set-key (kbd "s-s") 'eshell)

(setq mouse-wheel-scroll-amount '(5))

(global-set-key (kbd "C-V") 'yank)              ;; 粘贴
(global-set-key (kbd "C-Z") 'undo)              ;; 剪切
(global-set-key (kbd "C-k") 'kill-line)

(global-set-key (kbd "C-SPC") 'toggle-input-method)

(defun my-kill-then-yank ()
  "剪切當前行/區域，然後立即粘貼回來（相當於複製）"
  (interactive)
  (kill-whole-line)
  (yank))
;; 綁定快捷鍵
(global-set-key (kbd "M-k") 'my-kill-then-yank)

(defalias 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "<f1>") 'dired)

(global-set-key 
 (kbd "<f2>") 
 (lambda ()
   (interactive)
   (let ((display-buffer-overriding-action
          '((display-buffer-pop-up-frame . nil))))
     (dired "~/.emacs.d/lisp/"))))
(global-set-key (kbd "<f7>") 'kmacro-start-macro-or-insert-counter)

(global-set-key (kbd "M-]") 'ff-find-other-file)

(global-set-key (kbd "<f5>") 'compile)

(defun open-init-file()
  (interactive)
  (find-file-other-frame "~/.emacs.d/init.el"))
	

(defun open-init-keybindings()
  (interactive)
  (find-file "~/.emacs.d/lisp/init-keybindings.el"))
;;;for treemacs
(global-set-key (kbd "s-a") 'treemacs)
;;;-for treemacs

;;;for org-mode
(global-set-key (kbd "M-s ") 'org-redisplay-inline-images)

(define-key minibuffer-local-map (kbd "C-c C-e") 'embark-export-write)

;;;-for org-mode

(provide 'mouse&keybindings)
