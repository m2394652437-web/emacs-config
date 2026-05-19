(when (fboundp 'pixel-scroll-precision-mode)
  (pixel-scroll-precision-mode 1)
  (setq pixel-scroll-precision-use-momentum t)) 

(defalias 'yes-or-no-p 'y-or-n-p)

(bind-key "C-V" 'yank)
(bind-key "C-Z" 'undo) 
(bind-key "C-k" 'kill-line)
(bind-key "C-a" 'back-to-indentation)
(bind-key "C-<tab>" 'hs-toggle-hiding)

;;smart delete region
(defun delete-word-no-copy ()
  (interactive)
  (let ((start (point))
        (end (save-excursion
               (backward-word 1)
               (point))))
    (delete-region end start)))

(defun smart-delete-spaces-to-word ()
  (interactive)
  (let ((orig-pos (point)))
    (skip-chars-backward " \t")
    (if (= (point) orig-pos)
        (delete-word-no-copy)           
      (delete-region (point) orig-pos))))

(global-set-key (kbd "C-<backspace>") 'smart-delete-spaces-to-word)
(global-set-key (kbd "M-DEL") 'smart-delete-spaces-to-word)

;;org
(with-eval-after-load 'org
(bind-key "C-<return>" 'org-insert-todo-heading-respect-content org-mode-map)
(bind-key "C-`" 'org-latex-preview org-mode-map)
)

;; password store
(bind-key "C-P" 'password-store-copy)
;; input method
(bind-key "C-\\" 'toggle-input-method)

;;dirvish
(with-eval-after-load 'dirvish
(bind-key  "C-h" 'dired-omit-mode dirvish-mode-map)
(bind-key "<left>" 'dired-up-directory dirvish-mode-map)
(bind-key "<right>" 'dired-find-file dirvish-mode-map)
(bind-key "C-<tab>" 'dirvish-subtree-clear dirvish-mode-map)
(bind-key "<tab>" 'dirvish-subtree-toggle dirvish-mode-map)
)

(bind-key  "C-c m" 'bookmark-set)    
(bind-key  "C-c g" 'bookmark-jump)   
;; 寄存器快速跳转
(bind-key "C-c s" 'point-to-register)
(bind-key "C-c f" 'jump-to-register) 

(bind-key "<f1>" 'dired)
(bind-key "<f2>" 'ibuffer)
(bind-key "<f3>" 'lsp-bridge-peek)
(bind-key "<f4>" 'lsp-bridge-find-def)
(bind-key "<f5>" 'compile)
(bind-key "<f7>" 'kmacro-start-macro-or-insert-counter)

(bind-key "M-<f2>"
	  (lambda ()
	    (interactive)
	    (dired "~/.emacs.d/lisp/")))

(defun my-kill-then-yank ()
  (interactive)
  (kill-whole-line)
  (yank))

;; kill then yank
(bind-key "M-k" 'my-kill-then-yank)
(bind-key "M-s" 'ghostel)
(bind-key "M-," 'ace-window)
(bind-key "M-." 'other-window)
(bind-key "M-P" 'password-store-copy)
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
  (find-file "~/.emacs.d/init.el"))

(defun hotkeys()
  (interactive)
  (find-file "~/.emacs.d/lisp/keybindings.el"))

;; super
(if (display-graphic-p)
    ;; GUI
    (progn
      ;;(bind-key "s-a" 'dirvish-side)
      (bind-key "s-a" (lambda () (interactive) (dirvish-side  my-dirvish-side-dir)))
      )

  ;; CLI
  (progn
    ;;(bind-key "M-a" 'dirvish-side)
    (bind-key "M-a" (lambda () (interactive) (dirvish-side my-dirvish-side-dir)))
    )
  )
;; end super

(provide 'keybindings)
