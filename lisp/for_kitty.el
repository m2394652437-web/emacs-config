(add-to-list 'load-path (expand-file-name "lisp/for_kitty" user-emacs-directory))

(require 'kkp)
(global-kkp-mode 1)

(when (and (not (display-graphic-p)) (getenv "KITTY_PID"))
;;if in kitty
(require 'kitty-graphics)
(kitty-graphics-mode 1)
;;end if 
)

(provide 'for_kitty)
