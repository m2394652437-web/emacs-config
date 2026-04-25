;; counsel
(use-package counsel
  :config
  (global-set-key (kbd "C-c i") 'counsel-imenu)
  (global-set-key (kbd "C-c b") 'counsel-bookmark)
  (global-set-key (kbd "C-c t") 'counsel-recentf))

(global-set-key (kbd "C-c m") 'bookmark-set)    
(global-set-key (kbd "C-c g") 'bookmark-jump)   

;; 寄存器快速跳转
(global-set-key (kbd "C-c s") 'point-to-register)
(global-set-key (kbd "C-c f") 'jump-to-register) 

;;
(use-package hydra
  :ensure t)
(defhydra hydra-buffer-menu (:color red
				    :hint nil)
"
^Mark^
--------
_n_: next       
_p_: previous          
_a_: all        
_l_: lines       
"
  ("n" mc/mark-next-like-this)
  ("p" mc/mark-previous-like-this)
  ("a" mc/mark-all-like-this)
  ("l" mc/edit-lines)

  ("ESC" nil "cancel"))

(global-set-key (kbd "C-<tab>") 'hydra-buffer-menu/body)


(defun freedom-context-menu (event)
  (interactive "e")
  (let ((menu (easy-menu-create-menu
               "Menu"
               '(["Copy" kill-ring-save]
                 ["Paste" yank]
                 ["Scroll up" scroll-up-command]
                 ["Scroll down" scroll-down-command]))))
    (x-popup-menu event menu)))

(global-set-key [mouse-3] 'freedom-context-menu)
(provide 'menu&bookmark)
