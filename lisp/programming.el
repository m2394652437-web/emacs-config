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

;;default command to compile c
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
;;end default command to compile c

;;default command to compile cpp
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
;;end default command to compile cpp


;;default command to compile python
(add-hook 'python-mode-hook
          (lambda ()
            (when buffer-file-name
              (setq-local compile-command
                (concat "python3 " 
                       (shell-quote-argument 
                        (file-name-nondirectory buffer-file-name)))))))
;;end default command to compile python

;; Yasnippet
(use-package yasnippet)
(yas-global-mode 1)
;; end Yasnippet

;;lsp bridge
(add-to-list 'load-path "~/.emacs.d/lisp/lsp-bridge-master")

(setq lsp-bridge-python-command 
      (expand-file-name "~/.emacs.d/lsp-bridge-env/bin/python3"))

(setq lsp-bridge-python-lsp-server "pyright")
(setq lsp-bridge-c-lsp-server "clangd")
(setq lsp-bridge-g-lsp-server "glsl_analyzer")
(with-eval-after-load 'lsp-bridge
  (add-to-list 'lsp-bridge-single-lang-server-mode-list
               '(glsl-mode . "glsl_analyzer")))

(setq lsp-bridge-enable-search-words t
      lsp-bridge-enable-inlay-hint t
      lsp-bridge-enable-diagnostics t)

(require 'lsp-bridge)
(global-lsp-bridge-mode)

(add-hook 'simpc-mode-hook #'lsp-bridge-mode)

(setq lsp-bridge-enable-auto-import nil)
(setq acm-enable-comment-parse nil) 
(setq lsp-bridge-enable-log nil)

(with-eval-after-load 'lsp-bridge
  (add-hook 'simpc-mode-hook
            (lambda ()
              (when (derived-mode-p 'simpc-mode)
                (lsp-bridge-mode 1)))))
(define-key lsp-bridge-mode-map (kbd "<f3>") #'lsp-bridge-peek)
(define-key lsp-bridge-mode-map (kbd "<f4>") #'lsp-bridge-find-def)


;;if CLI
(use-package popon)
(unless (display-graphic-p)
  (require 'acm-terminal)
  )
;;end lsp bridge

;;mutiple-cursors
(use-package multiple-cursors
  :ensure t)
;;end multiple-cursors


(provide 'programming)
