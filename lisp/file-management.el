;;用dired时省略emcas自动备份文件
(add-hook 'dired-mode-hook 'dired-omit-mode)
(add-hook 'dired-mode-hook 'auto-revert-mode)

(use-package dirvish
  :straight ( :host github
	      :repo "alexluigit/dirvish"
	      :branch "main")
  :defer nil
  :config
  (dirvish-override-dired-mode)
  (dirvish-side-follow-mode)
  (setq dirvish-attributes '(nerd-icons			    
			     file-size
			     ))
  (setq dirvish-side-attributes '(nerd-icons))
  
  (defcustom my-dirvish-side-dir nil
    "Default directory. If nil, use ~."
    :group 'dirvish
    :type '(choice (directory :tag "Directory")
                   (const :tag "Home" nil)))

  (defun my-dirvish-side-dir-or-home ()
    (or (and my-dirvish-side-dir (not (string-empty-p my-dirvish-side-dir))
             my-dirvish-side-dir)
	"~"))

  (defun my-dirvish-side-set-dir ()
    (interactive)
    (let ((new-dir (read-directory-name "Dir: " "~")))
      (setq my-dirvish-side-dir
            (unless (string-empty-p (string-trim new-dir)) new-dir))
      (customize-save-variable 'my-dirvish-side-dir my-dirvish-side-dir)))

  )  

(provide 'file-management)
