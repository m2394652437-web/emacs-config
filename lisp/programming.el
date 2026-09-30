;;; -*- lexical-binding: t; -*-
(setq process-connection-type t)

(defun my-compile-comint (cmd)
  "Compile in comint mode — buffer is editable, next-error still works."
  (interactive
   (list (read-shell-command "Compile: "
			     (if (functionp 'compile-command)
				 (funcall 'compile-command)
			       (eval compile-command)))))
  (compile cmd t))

(use-package magit
  :straight ( :host github
	      :repo "magit/magit"))

;;; ============================================================
;;; Formatters — unified via reformatter
;;; ============================================================

(use-package reformatter
  :config

  ;; C/C++ — astyle (supports stdin)
  (reformatter-define c-format
    :program "astyle"
    :args '("--style=kr" "--suffix=none")
    :lighter " CF")

  ;; Python — ruff (supports stdin)
  (reformatter-define python-format
    :program "ruff"
    :args '("format" "-")
    :lighter " PF")

  ;; Rust — rustfmt (supports stdin)
  (reformatter-define rust-format
    :program "rustfmt"
    :args '("--emit=stdout")
    :lighter " RF")

  ;; NASM assembly — nasfmt (no stdin, uses temp file)
  (reformatter-define asm-format
    :program "~/.cargo/bin/nasfmt"
    :args nil
    :stdin nil
    :lighter " AF"))

;;; -----------------------------------------------------------
;;; Mode hooks — format key + format-on-save
;;; -----------------------------------------------------------

(defun my/setup-format-keys (format-fn)
  "Bind C-S-f to FORMAT-FN and enable format-on-save for the buffer."
  (local-set-key (kbd "C-S-f") format-fn)
  (add-hook 'before-save-hook format-fn nil t))

;; C / C++
(dolist (hook '(c-mode-hook c++-mode-hook))
  (add-hook hook (lambda () (my/setup-format-keys #'c-format-buffer))))

;; Python
(add-hook 'python-mode-hook (lambda () (my/setup-format-keys #'python-format-buffer)))

;; Rust
(add-hook 'rust-mode-hook (lambda () (my/setup-format-keys #'rust-format-buffer)))

;; Zig — uses zig-mode's built-in reformatter definition
(add-hook 'zig-mode-hook (lambda () (my/setup-format-keys #'zig-format-buffer)))

;; NASM assembly
(add-hook 'asm-mode-hook
          (lambda ()
            (setq-local tab-width 4
                        indent-tabs-mode nil)
            (my/setup-format-keys #'asm-format-buffer)))

;;end style

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
           (ext (file-name-extension buffer-file-name))
           (proj-root (condition-case nil
                          (projectile-project-root)
                        (error nil)))
           (cd-prefix (if (and proj-root
                               (not (string= (expand-file-name dir)
                                             (expand-file-name proj-root))))
                          (concat "cd " (shell-quote-argument proj-root) " && ")
                        "")))

      (cond
       ;; C 文件
       ((string= ext "c")
        (let* ((current-file (file-name-nondirectory buffer-file-name))
               (output-name (file-name-sans-extension current-file))
               (c-files (directory-files dir nil "\\.c$")))
          (when c-files
            (setq-local compile-command
			(concat cd-prefix
                                "gcc "
                                (mapconcat #'shell-quote-argument c-files " ")
                                " -o " output-name)))))
 
       ;; C++ 文件
       ((string= ext "cpp")
        (let ((cpp-files (directory-files dir nil "\\.cpp$")))
          (when cpp-files
            (setq-local compile-command
                        (concat cd-prefix
                                "g++ "
                                (mapconcat #'shell-quote-argument cpp-files " ")
                                " -o main")))))

       ;; Python 文件
       ((string= ext "py")
        (setq-local compile-command
                    (concat cd-prefix
                            "python3 "
                            (shell-quote-argument
                             (file-name-nondirectory buffer-file-name)))))))))


(add-hook 'c-mode-hook 'setup-local-compile-command)
(add-hook 'c++-mode-hook 'setup-local-compile-command)
(add-hook 'python-mode-hook 'setup-local-compile-command)


;; Yasnippet
(use-package yasnippet
  :ensure t
  :defer nil
  :config
  (yas-global-mode 1)
  (add-hook 'snippet-mode-hook (lambda () (tree-sitter-mode -1))) ;
  )
;; end Yasnippet
                      
(unless (display-graphic-p)
  (straight-use-package
   '(popon :host nil :repo "https://codeberg.org/akib/emacs-popon.git"))
  (straight-use-package
   '(acm-terminal :host github :repo "twlz0ne/acm-terminal")))

;;; lsp-bridge
(use-package lsp-bridge
    :straight '(lsp-bridge :type git :host github :repo "manateelazycat/lsp-bridge"
            :files (:defaults "*.el" "*.py" "acm" "core" "langserver" "multiserver" "resources")
            :build (:not compile))
  :defer t
  :hook (prog-mode . lsp-bridge-mode)
  :config

  (setq lsp-bridge-python-command
	(expand-file-name "lsp-bridge-env/bin/python3" user-emacs-directory))

  ;; lang server
  (setq lsp-bridge-python-lsp-server "pyright"
	lsp-bridge-c-lsp-server "clangd"
	lsp-bridge-rust-lsp-server "rust-analyzer"
	
	)
 
  (setq lsp-bridge-enable-search-words t
	lsp-bridge-enable-diagnostics t
	lsp-bridge-enable-inlay-hint t
	lsp-bridge-enable-auto-import nil
	lsp-bridge-enable-log nil
	acm-enable-comment-parse nil
	)
  
  (with-eval-after-load 'lsp-bridge
    (add-to-list 'lsp-bridge-single-lang-server-mode-list
		 '(glsl-mode . "glsl_analyzer"))
    (add-to-list 'lsp-bridge-single-lang-server-mode-list
		 '(bash-mode . "bash-language-server")))
  
  ;; if in CLI
  (unless (display-graphic-p)
    (require 'acm-terminal))
  )

(defun my/toggle-acm-terminal ()
  "Toggle acm-terminal for terminal frames."
  (interactive)
  (if (featurep 'acm-terminal)
      (progn
        (ignore-errors (acm-hide))      ; clean up popon overlays
        (acm-terminal-deactive)          ; remove advices
        (setq acm-menu-frame nil         ; clear stale frame refs
              acm-doc-frame nil)
        (unload-feature 'acm-terminal)
        (message "acm-terminal disabled (child-frame mode)"))
    (require 'acm-terminal)
    (unless (display-graphic-p)
      (acm-terminal-active))
    (message "acm-terminal enabled (terminal mode)")))

;;end lsp bridge

;; multiple-cursors
(use-package multiple-cursors
  :defer t
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-pruevious-like-this)
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
