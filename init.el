(setq frame-inhibit-implied-resize t)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lisp/static-packages" user-emacs-directory))

(setq make-backup-files nil)
(setq auto-save-default nil)

(setq tramp-mode t)
(setq tramp-gvfs-enabled t)
(setq tramp-default-remote-shell "/bin/sh")

(setq long-line-threshold 100000)
(setq long-line-optimizations-region-size 500000)

(add-hook 'after-init-hook
  (lambda ()
    (setq gc-cons-threshold 800000)
    (message "GC threshold restored to %s" gc-cons-threshold)))

(if (file-exists-p (expand-file-name "lisp/privacy.el" user-emacs-directory))
    (require 'privacy)
  (require 'privacy-example)
  (message "No privacy configuration found. "))

;;启用service 需要 ./setup-service.sh

(require 'startup)
(require 'keybindings)
(require 'packages)
(require 'file-management)
(require 'buffer-management)
(require 'insert)
(require 'programming)
(require 'for-shell)
(require 'modes)
(require 'menu&bookmark)
(require 'ui)
(require 'custom)

;;not for server
(require 'for-kitty)
(require 'org-mode-settings)
(require 'email)
(require 'ai)
