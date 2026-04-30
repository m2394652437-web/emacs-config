(use-package magit)

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

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (define-key simpc-mode-map (kbd "C-f") 'astyle-buffer)
	    (define-key c++-mode-map (kbd "C-f") 'astyle-buffer)))

(use-package projectile
  :ensure t
  :defer t
  :init
  (setq projectile-mode-line-prefix " Proj"
	projectile-enable-caching t)
  :config
  (projectile-mode +1)
  (setq projectile-switch-project-action 'projectile-vc))

(defun setup-local-compile-command ()
  "设置当前buffer的编译命令（根据文件类型）"
  (when buffer-file-name
    (let* ((dir (file-name-directory buffer-file-name))
           (ext (file-name-extension buffer-file-name)))
      (cond
       ;; C 文件
       ((string= ext "c")
        (let* ((current-file (file-name-nondirectory buffer-file-name))
               (output-name (file-name-sans-extension current-file))
               (c-files (directory-files dir nil "\\.c$")))
          (when c-files
            (setq-local compile-command
                        (concat "gcc "
                                (mapconcat #'shell-quote-argument c-files " ")
                                " -o " output-name)))))
       ;; C++ 文件
       ((string= ext "cpp")
        (let ((cpp-files (directory-files dir nil "\\.cpp$")))
          (when cpp-files
            (setq-local compile-command
                        (concat "g++ "
                                (mapconcat #'shell-quote-argument cpp-files " ")
                                " -o main")))))
       ;; Python 文件
       ((string= ext "py")
        (setq-local compile-command
                    (concat "python3 "
                            (shell-quote-argument
                             (file-name-nondirectory buffer-file-name)))))))))


(add-hook 'c-mode-hook 'setup-local-compile-command)
(add-hook 'c++-mode-hook 'setup-local-compile-command)
(add-hook 'python-mode-hook 'setup-local-compile-command)


;; Yasnippet
(use-package yasnippet
  :ensure t
  :defer t
  :config
  (yas-global-mode 1))
;; end Yasnippet

;;; lsp-bridge
(add-to-list 'load-path (expand-file-name "lisp/static_packages/lsp-bridge-master" user-emacs-directory))
(setq lsp-bridge-python-command
      (expand-file-name "lsp-bridge-env/bin/python3" user-emacs-directory))

;; lang server
(setq lsp-bridge-python-lsp-server "pyright"
      lsp-bridge-c-lsp-server "clangd"
      lsp-bridge-g-lsp-server "glsl_analyzer")

(setq lsp-bridge-enable-search-words t
      lsp-bridge-enable-diagnostics t
      lsp-bridge-enable-inlay-hint t
      lsp-bridge-enable-auto-import nil
      lsp-bridge-enable-log nil
      acm-enable-comment-parse nil
      )

(use-package lsp-bridge
  :straight nil
  :defer t
  :hook (((prog-mode org-mode) . lsp-bridge-mode)
         ;;(lsp-bridge-mode . lsp-bridge-semantic-tokens-mode)
	 )
  :config
  ;; glsl server
  (with-eval-after-load 'lsp-bridge
    (add-to-list 'lsp-bridge-single-lang-server-mode-list
		 '(glsl-mode . "glsl_analyzer")))

  ;; if in CLI
  (unless (display-graphic-p)
    (require 'acm-terminal)
    (use-package popon)))
;; end lsp-bridge

;; multiple-cursors
(use-package multiple-cursors
  :defer t
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

;; 自动清理临时文件
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq lexical-binding t)))

;;high light
;;need M-x tree-sitter-install-lang first
(use-package tree-sitter-langs)
(add-hook 'prog-mode-hook 'tree-sitter-hl-mode)

(add-hook 'prog-mode-hook 'hs-minor-mode)

(provide 'programming)
