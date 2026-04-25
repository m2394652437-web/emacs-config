(defun astyle-buffer ()
  (interactive)
  (let ((saved-line-number (line-number-at-pos)))
    (shell-command-on-region
     (point-min)
     (point-max)
     "astyle --style=kr"
     nil
     t)
    (goto-line saved-line-number)))
(global-set-key (kbd "C-f") 'astyle-buffer)

;;;;projectile
(use-package projectile
  :ensure t
  :init
  (projectile-mode +1))

(setq projectile-switch-project-action 'projectile-vc)
;;;;default command to compile c
(add-hook 'simpc-mode-hook
          (lambda ()
            (when buffer-file-name
              (let* ((dir (file-name-directory buffer-file-name))
                     (current-file-name (file-name-nondirectory buffer-file-name))
                                       (output-name (file-name-sans-extension current-file-name))
                                       (c-files (directory-files dir nil "\\.c$")))
                (when c-files
                  (setq-local compile-command
                              (concat "gcc " 
                                      (mapconcat #'shell-quote-argument c-files " ")
                                      " -o " output-name)))))))
;;;;default command to compile cpp
(add-hook 'simpc-mode-hook
          (lambda ()
            (when buffer-file-name
              (let* ((dir (file-name-directory buffer-file-name))
                     (cpp-files (directory-files dir nil "\\.cpp$")))
                (when cpp-files
                  (setq-local compile-command
                              (concat "g++ " 
                                      (mapconcat #'shell-quote-argument cpp-files " ")
                                      " -o main")))))))

;;;;default command to compile python
(add-hook 'python-mode-hook
          (lambda ()
            (when buffer-file-name
              (setq-local compile-command
                (concat "python3 " 
                       (shell-quote-argument 
                        (file-name-nondirectory buffer-file-name)))))))


(provide 'programming)
