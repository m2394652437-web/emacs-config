;;; startup.el
(setq gc-cons-threshold 33554432
      undo-auto-current-boundary-timer nil)

(setq initial-major-mode 'fundamental-mode)
(setq initial-scratch-message initial-message)

;;(setq load-prefer-newer t)

;;straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq use-package-always-defer t)

(setq straight-use-package-by-default t)
;;end straight

(setenv "PYTHON_BASIC_REPL" "1")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8)

;; 环境变量
(use-package exec-path-from-shell
  :demand t
  :config
  (exec-path-from-shell-initialize))

;; Custom
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(provide 'startup)
