(straight-use-package
 '(monet :type git :host github :repo "stevemolitor/monet"))

;; install required inheritenv dependency:
(use-package inheritenv
  :straight (:type git :host github :repo "purcell/inheritenv"))

;; install claude-code.el, using :depth 1 to reduce download size:
(use-package claude-code
  :straight (:type git :host github :repo "stevemolitor/claude-code.el" :branch "main" :depth 1
                   :files ("*.el" (:exclude "images/*")))
  :bind-keymap
  ("C-c c" . claude-code-command-map) ;; or your preferred key
  ;; Optionally define a repeat map so that "M" will cycle thru Claude auto-accept/plan/confirm modes after invoking claude-code-cycle-mode / C-c M.
  :config
  (setq claude-code-terminal-backend 'ghostel)
  (monet-mode 1)
  (claude-code-mode))

(defun my-claude-notify (title message)
  "Display a Linux notification using notify-send."
  (if (executable-find "notify-send")
      (call-process "notify-send" nil nil nil title message)
    (message "%s: %s" title message)))

(setq claude-code-notification-function #'my-claude-notify)

(defun my-claude-notify-with-sound (title message)
  "Display a Linux notification with sound."
  (when (executable-find "notify-send")
    (call-process "notify-send" nil nil nil title message))
  ;; Play sound if paplay is available
  (when (executable-find "paplay")
    (call-process "paplay" nil nil nil "/usr/share/sounds/freedesktop/stereo/message.oga")))

(setq claude-code-notification-function #'my-claude-notify-with-sound)

(provide 'ai)
