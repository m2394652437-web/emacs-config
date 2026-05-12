(add-to-list 'load-path (expand-file-name "lisp/for-kitty" user-emacs-directory))

(require 'kkp)
(global-kkp-mode 1)

(when (and (not (display-graphic-p)) (getenv "KITTY_PID"))
;;if in kitty
(require 'kitty-graphics)
(kitty-graphics-mode 1)
;;end if 
)

(unless (display-graphic-p)                                                                                                                                                                                                      
  (define-key input-decode-map "\e[9u" [tab])
  (define-key input-decode-map "\e[9;2u" [backtab])
  (define-key input-decode-map "\e[9;5u" [C-tab]))    

(provide 'for-kitty)
