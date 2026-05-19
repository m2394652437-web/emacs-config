;;if in kitty
(when (and (not (display-graphic-p)) (getenv "KITTY_PID"))
  (add-to-list 'load-path (expand-file-name "lisp/static-packages/for-kitty" user-emacs-directory))
  
  (require 'kkp)
  (global-kkp-mode 1)

  (require 'kitty-graphics)
  (kitty-graphics-mode 1)
  )

(provide 'for-kitty)
