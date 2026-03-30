(setq frame-inhibit-implied-resize t)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(require 'startup)
(require 'utils)
(require 'mouse&keybindings)
(require 'packages)
(require 'file_management)
(require 'insert)
(require 'programming)
(require 'ui)
(require 'org_mode_settings)
(require 'custom)
(require 'simpc-mode)
(require 'for_kitty)
(require 'menu&bookmark)
(add-to-list 'auto-mode-alist '("\\.[hc]?\\'" . simpc-mode))



