(use-package glsl-mode
  :defer t)

(use-package rust-mode
  :defer t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(use-package cargo-mode
  :hook
  (rust-mode . cargo-minor-mode)
  :config
  (setq compilation-scroll-output t)
  (when cargo-mode-use-comint
    (advice-add 'cargo-mode--start-cmd :override
                (lambda (name cmd project-root)
                  (let* ((buffer-name (concat "*cargo-mode " name "*"))
                         (default-directory (or project-root default-directory)))
                    (save-some-buffers
                     (not compilation-ask-about-save)
                     (lambda ()
                       (and project-root
                            buffer-file-name
                            (string-prefix-p project-root
                                             (file-truename buffer-file-name)))))
                    (setq cargo-mode--last-command (list name cmd project-root))
                    (when-let ((buf (get-buffer buffer-name)))
                      (kill-buffer buf))
                    (compile cmd t)
                    (with-current-buffer "*compilation*"
                      (rename-buffer buffer-name)
                      (setq-local truncate-lines t)
                      (local-set-key (kbd "q") 'kill-buffer-and-window)
                      (local-set-key (kbd "g") 'cargo-mode-last-command))
                    (get-buffer-process buffer-name)))))
  :custom
  (cargo-mode-use-comint t))


(use-package zig-mode)

;; (add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-ts-mode))
;; (add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-ts-mode))
;; (setq treesit-font-lock-level 4)

;;(require 'simpc-mode)
;; (add-to-list 'auto-mode-alist '("\\.[hc]?\\'" . simpc-mode))

(provide 'modes)
