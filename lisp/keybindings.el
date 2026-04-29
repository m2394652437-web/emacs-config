
(defalias 'yes-or-no-p 'y-or-n-p)
(setq mouse-wheel-scroll-amount '(1))

(bind-key "C-V" 'yank)
(bind-key "C-Z" 'undo) 
(bind-key "C-k" 'kill-line)
(bind-key "C-a" 'back-to-indentation)
(bind-key "C-<tab>" 'hs-toggle-hiding)
;; password store
(bind-key "C-P" 'password-store-copy)
;; input method
(bind-key "C-\\" 'toggle-input-method)

(bind-key "<f1>" 'dired)
(bind-key "<f2>"
	  (lambda ()
	    (interactive)
	    (dired "~/.emacs.d/lisp/")))
(bind-key "<f5>" 'compile)
(bind-key "<f7>" 'kmacro-start-macro-or-insert-counter)

(defun my-kill-then-yank ()
  (interactive)
  (kill-whole-line)
  (yank))

;; kill then yank
(bind-key "M-k" 'my-kill-then-yank)
(bind-key "M-s" 'eshell)
(bind-key "M-P" 'password-store-copy)
(bind-key "M-a" 'treemacs)
(bind-key "M-," 'ace-window)
(bind-key "M-." 'other-window)
(bind-key "M-b" 'hydra-buffer-menu/body)
(bind-key "M-]"
(lambda ()
  (interactive)
  (let ((ff-search-directories '("." "src" "include" ".." "../src" "../include")))
    (ff-find-other-file t)
    (delete-other-windows)
    ))) 

;; org-mode
(bind-key "M-p" 'org-redisplay-inline-images)
(define-key minibuffer-local-map (kbd "C-c C-e") 'embark-export-write)

(defun open-init-file()
  (interactive)
  (find-file-other-frame "~/.emacs.d/init.el"))

(defun hotkeys()
  (interactive)
  (find-file "~/.emacs.d/lisp/keybindings.el"))

;; super
(if (display-graphic-p)
    ;; GUI
    (progn
      (bind-key "s-a" 'treemacs)
      )

  ;; CLI
  (progn
    (bind-key "M-a" 'treemacs)
    
    )
  )
;; end super

(provide 'keybindings)
