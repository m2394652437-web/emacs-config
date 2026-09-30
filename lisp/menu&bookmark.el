;;; -*- lexical-binding: t; -*-
(use-package hydra)
(defhydra hydra-buffer-menu (:color red
				    :hint nil)
"
^Mark^
--------
_n_: next       _b_:imenu
_p_: previous          
_a_: all        
_l_: lines       
"
  ("n" mc/mark-next-like-this)
  ("p" mc/mark-previous-like-this)
  ("a" mc/mark-all-like-this)
  ("l" mc/edit-lines)
  ("b" consult-imenu)
  ("ESC" nil "cancel"))

(defhydra hydra-file-group-menu (:color blue
                                 :hint nil)
  "
^File groups^
------------------------
_o_: open       _R_: rebuild
_c_: create     _a_: add files
_r_: remove     _d_: delete
"
  ("o" my-file-group-open)
  ("R" my-file-group-rebuild)
  ("c" my-file-group-create)
  ("a" my-file-group-add-files)
  ("r" my-file-group-remove-files)
  ("d" my-file-group-delete)
  ("ESC" nil "cancel"))

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
