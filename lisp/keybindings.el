;;; -*- lexical-binding: t; -*-
(when (fboundp 'pixel-scroll-precision-mode)
  (pixel-scroll-precision-mode 1)
  (setq pixel-scroll-precision-use-momentum t)) 

(defalias 'yes-or-no-p 'y-or-n-p)

(bind-key "C-V" 'yank)
(bind-key "C-Z" 'undo) 
(bind-key "C-k" 'kill-line)
(bind-key "C-a" 'back-to-indentation)
(bind-key "C-<tab>" 'hs-toggle-hiding)



"Delimiters are always detected"
(defvar my-word-stop-chars '(?. ?\" ?;))

;; smart word move
(defun my--word-move (fwd)
  "Move one step forward (FWD=t) or backward (FWD=nil),
stopping at delimiters and `my-word-stop-chars'."
  (let* ((stop-p (lambda (c) (and c (or (memq c my-word-stop-chars)
                                       (memq (char-syntax c) '(?\( ?\)))))))
         (on-delim (and (not (if fwd (eobp) (bobp)))
                        (if fwd
                            (funcall stop-p (char-after))
                          (or (funcall stop-p (char-before))
                              (funcall stop-p (char-after)))))))
    (if on-delim
        (funcall (if fwd #'forward-char #'backward-char) 1)
      (let* ((orig (point))
             (bound (save-excursion
                      (funcall (if fwd #'forward-word #'backward-word) 1)
                      (point)))
             (stuck (if fwd (<= bound orig) (>= bound orig))))
        (if stuck
            (funcall (if fwd #'forward-char #'backward-char) 1)
          (let* ((regex (concat "\\s(\\|\\s)\\|"
                                (regexp-opt (mapcar #'char-to-string my-word-stop-chars))))
                 (stop (save-excursion
                         (if fwd
                             (if (re-search-forward regex bound t) (match-beginning 0) bound)
                           (if (re-search-backward regex bound t) (point) bound))))
                 (target (if fwd (min stop bound) (max stop bound))))
            (goto-char target)))))))

(defun my--right-word-advice (orig-fun &rest args)
  (let* ((arg (or (car args) 1))
        (fwd (< arg 0)))              ; negative arg → backward
    (dotimes (_ (abs arg))
      (my--word-move (not fwd)))))

(defun my--left-word-advice (orig-fun &rest args)
  (let* ((arg (or (car args) 1))
        (rev (< arg 0)))              ; negative arg → forward
    (dotimes (_ (abs arg))
      (my--word-move rev))))

(advice-add 'right-word :around #'my--right-word-advice)
(advice-add 'left-word  :around #'my--left-word-advice)

(bind-key "C-}" 'shrink-window-horizontally)
(bind-key "C-{" 'enlarge-window-horizontally)
(bind-key "C-:" 'enlarge-window)
(bind-key "C-\"" 'shrink-window)

(bind-key "C-x <down>"
          (lambda ()
            (interactive)
            (kill-current-buffer)
            (delete-window)))
(bind-key "C-x C-<down>"
          (lambda ()
            (interactive)
            (kill-current-buffer)
            (delete-window)))

;;smart delete region
(defun delete-word-no-copy ()
  "Delete backward one step: delimiter/stop-char, or a word.
Uses the same logic as `C-<left>'."
  (interactive)
  (let ((start (point)))
    (delete-region (save-excursion (my--word-move nil) (point))
                   start)))

(defun smart-delete-spaces-to-word ()
  (interactive)
  (let ((orig-pos (point)))
    (skip-chars-backward " \t")
    (if (= (point) orig-pos)
        (delete-word-no-copy)           
      (delete-region (point) orig-pos))))

(global-set-key (kbd "C-<backspace>") 'smart-delete-spaces-to-word)
(global-set-key (kbd "M-<backspace>") 'smart-delete-spaces-to-word)

;;org
(with-eval-after-load 'org
(bind-key "C-<return>" 'org-insert-todo-heading-respect-content org-mode-map)
(bind-key "C-`" 'org-latex-preview org-mode-map)
(bind-key "C-S-<down>" 'org-next-visible-heading org-mode-map)
(bind-key "C-S-<up>" 'org-previous-visible-heading org-mode-map)
)

;; password store
(bind-key "M-p" 'password-store-copy)
;; input method
(bind-key "C-\\" 'toggle-input-method)

;;dirvish
(with-eval-after-load 'dirvish
(bind-key  "C-h" 'dired-omit-mode dirvish-mode-map)
(bind-key "<left>" 'dired-up-directory dirvish-mode-map)
(bind-key "<right>" 'dired-find-file dirvish-mode-map)
(bind-key "C-<tab>" 'dirvish-subtree-clear dirvish-mode-map)
(bind-key "TAB" 'dirvish-subtree-toggle dirvish-mode-map)
)

(bind-key  "C-c m" 'bookmark-set)    
(bind-key  "C-c g" 'bookmark-jump)   
;; 寄存器快速跳转
(bind-key "C-c s" 'point-to-register)
(bind-key "C-c f" 'jump-to-register)
(bind-key "C-c w" 'hydra-file-group-menu/body)

(bind-key "<f1>" 'dired)
(bind-key "<f2>" 'ibuffer)
(bind-key "<f3>" 'lsp-bridge-peek)
(bind-key "<f4>" 'lsp-bridge-find-def)
(bind-key "<f5>" 'my-compile-comint)
(with-eval-after-load 'rust-mode
  (bind-key "<f5>" 'cargo-mode-execute-task rust-mode-map)
  )
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
;; 必须在此处 require：ff-search-directories 只有被 defvar 后，
;; 下面的 let 在 lexical-binding 下才会做动态绑定，ff-find-other-file 才看得到。
(require 'find-file)
(bind-key "M-]"
(lambda ()
  (interactive)
  (let ((ff-search-directories '("." "src" "include" ".." "../src" "../include")))
    (ff-find-other-file t)
    (delete-other-windows)
    ))) 

;; org-mode
;;(bind-key "M-p" 'org-redisplay-inline-images)
(define-key minibuffer-local-map (kbd "C-c C-e") 'embark-export-write)

(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun hotkeys()
  (interactive)
  (find-file "~/.emacs.d/lisp/keybindings.el"))

(bind-key "s-a" (lambda () (interactive) (dirvish-side  my-dirvish-side-dir)))
(bind-key "M-a" (lambda () (interactive) (dirvish-side my-dirvish-side-dir)))

(provide 'keybindings)
