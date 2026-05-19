;;rime 
(use-package rime
  :custom
  (rime-user-data-dir "~/.local/share/fcitx5/rime"))
(setq rime-show-candidate 'posframe) 
(setq default-input-method "rime")
;;end rime

;;+1
(defun my/increment-number-at-point ()
  "add 1 to number at cursor"
  (interactive)
  (let ((bounds (bounds-of-thing-at-point 'number)))
    (if bounds
        (let* ((beg (car bounds))
               (end (cdr bounds))
               (num-str (buffer-substring-no-properties beg end))
               (num (string-to-number num-str)))
          (delete-region beg end)
          (insert (number-to-string (1+ num))))
      (message "No number found at cursor"))))
(global-set-key (kbd "C-+") 'my/increment-number-at-point)
;;end +1

(provide 'insert)

