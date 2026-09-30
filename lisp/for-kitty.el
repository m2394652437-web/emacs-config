;;; -*- lexical-binding: t; -*-
;;if in kitty
(unless (display-graphic-p)
  (add-to-list 'load-path (expand-file-name "lisp/static-packages/for-kitty" user-emacs-directory))
  
  (require 'kkp)
  (global-kkp-mode 1)

  ;; (require 'kitty-graphics)
  ;; (kitty-graphics-mode 1)
  )

(provide 'for-kitty)
