;;ibuffer
(use-package nerd-icons-ibuffer
  :ensure t
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(with-eval-after-load 'ibuffer
  
  (bind-key "<tab>" 'ibuffer-toggle-filter-group ibuffer-mode-map)
  (setq ibuffer-display-summary nil)
  (setq ibuffer-show-empty-filter-groups nil)
  
  (setq nerd-icons-ibuffer-formats
        '((mark modified locked " "
            (icon 2 2)
            (name 18 18 :left :elide)
            " "
            (size-h 9 -1 :right)
            " "
            (mode+ 16 16 :left :elide))
          (mark " " (name 16 -1))))

  (setq ibuffer-saved-filter-groups
	'(("group"
	   ("c" (or (mode . c-mode)))
	   ("cpp" (or (mode . c++-mode)))
	   ("python" (or (mode . python-mode)))
	   ("elisp" (or (mode . emacs-lisp-mode)))	 
	   ("other programs" (or (derived-mode . prog-mode)))
           ("orgs" (or (mode . org-mode)))
           ("magit" (or (mode . magit-status-mode)))
	   )))

  (add-hook 'ibuffer-hook
            (lambda ()
              (ibuffer-switch-to-saved-filter-groups "group")))

  )
;;end ibuffer

;;auto kill buffers
(defcustom auto-kill-buffer-modes '()
  "List of major modes whose buffers are auto-killed when hidden."
  :type '(repeat symbol)
  :group 'convenience)

(defcustom auto-kill-buffer-names '()
  "List of regexp patterns matching buffer names to auto-kill when hidden."
  :type '(repeat regexp)
  :group 'convenience)

;;;###autoload
(define-minor-mode auto-kill-buffer-mode
  "Automatically kill buffers of selected modes/names when they are no longer displayed.
See `auto-kill-buffer-modes' and `auto-kill-buffer-names'."
  :global t
  (if auto-kill-buffer-mode
      (add-hook 'window-configuration-change-hook #'auto-kill-buffer--cleanup)
    (remove-hook 'window-configuration-change-hook #'auto-kill-buffer--cleanup)))

(defun auto-kill-buffer--cleanup ()
  "Kill hidden buffers matching `auto-kill-buffer-modes' or `auto-kill-buffer-names'."
  (dolist (buf (buffer-list))
    (when (and (buffer-live-p buf)
               (not (get-buffer-window buf 'visible))
               (or (memq (buffer-local-value 'major-mode buf) auto-kill-buffer-modes)
                   (cl-some (lambda (re) (string-match-p re (buffer-name buf)))
                            auto-kill-buffer-names)))
      (kill-buffer buf))))

(add-to-list 'auto-kill-buffer-modes 'dired-mode)
(add-to-list 'auto-kill-buffer-modes 'special-mode)
(add-to-list 'auto-kill-buffer-modes 'help-mode)
(add-to-list 'auto-kill-buffer-modes 'emacs-lisp-compilation-mode)
(add-to-list 'auto-kill-buffer-modes 'ibuffer-mode)
(add-to-list 'auto-kill-buffer-names "\\*scratch\\*")

(auto-kill-buffer-mode 1)
;;end auto kill buffers

(provide 'buffer-management)
