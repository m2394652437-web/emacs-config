;;; -*- lexical-binding: t; -*-
(global-auto-revert-mode 1)

(setq dired-omit-files 
      (concat "\\`[#.]"      
              "\\|" 
              "\\`.*[~#]\\'" 
              "\\|" 
              "\\`\\.\\.\\'\\'" 
              ))

(add-hook 'dired-mode-hook 'dired-omit-mode)
(add-hook 'dired-mode-hook 'auto-revert-mode)

;;解决无法打开中文名文件夹
(setq dired-listing-switches
      "-l --almost-all --human-readable --group-directories-first --quoting-style=literal")

(defcustom my-file-groups nil
  "Named groups of files to open together in one window layout."
  :type '(alist :key-type (string :tag "Group name")
                :value-type (repeat :tag "Files" file))
  :group 'convenience)

(defun my-file-group--entry (name)
  "Return the file-group entry named NAME."
  (assoc name my-file-groups))

(defun my-file-group--read-name (&optional prompt)
  "Read an existing file-group name using PROMPT."
  (unless my-file-groups
    (user-error "No file groups; create one first"))
  (completing-read (or prompt "File group: ")
                   (mapcar #'car my-file-groups) nil t))

(defun my-file-group--normalize-file (file)
  "Return an absolute, abbreviated path for FILE."
  (abbreviate-file-name (expand-file-name file)))

(defun my-file-group--deduplicate (files)
  "Normalize FILES and remove duplicates without changing their order."
  (let (seen result)
    (dolist (file files (nreverse result))
      (let ((file (my-file-group--normalize-file file)))
        (unless (member file seen)
          (push file seen)
          (push file result))))))

(defun my-file-group--save ()
  "Persist `my-file-groups' in `custom-file'."
  (customize-save-variable 'my-file-groups my-file-groups))

(defun my-file-group-create (name)
  "Create an empty file group named NAME."
  (interactive (list (string-trim (read-string "New file group: "))))
  (when (string-empty-p name)
    (user-error "Group name cannot be empty"))
  (when (my-file-group--entry name)
    (user-error "File group already exists: %s" name))
  (setq my-file-groups
        (append my-file-groups (list (cons name nil))))
  (my-file-group--save)
  (message "Created file group: %s" name))

(defun my-file-group--files-for-add ()
  "Return files selected by the current context."
  (cond
   ((derived-mode-p 'dired-mode)
    (dired-get-marked-files))
   (buffer-file-name
    (list buffer-file-name))
   (t
    (list (read-file-name "File to add: " nil nil t)))))

(defun my-file-group-add-files (name files)
  "Add FILES to the file group NAME.
In Dired or Dirvish, FILES are the marked files.  In a file buffer,
FILES contains the current file; otherwise prompt for one file."
  (interactive (list (my-file-group--read-name "Add to group: ")
                     (my-file-group--files-for-add)))
  (let ((entry (my-file-group--entry name))
        valid ignored)
    (unless entry
      (user-error "Unknown file group: %s" name))
    (dolist (file (my-file-group--deduplicate files))
      (condition-case nil
          (if (file-regular-p (expand-file-name file))
              (push file valid)
            (push file ignored))
        (file-error (push file ignored))))
    (setq valid (nreverse valid))
    (unless valid
      (user-error "No regular files to add%s"
                  (if ignored " (directories or missing files were ignored)" "")))
    (let* ((current (my-file-group--deduplicate (cdr entry)))
           (updated (my-file-group--deduplicate (append current valid)))
           (added (- (length updated) (length current))))
      (if (zerop added)
          (message "All selected files are already in %s" name)
        (setcdr entry updated)
        (my-file-group--save)
        (message "Added %d file%s to %s%s"
                 added (if (= added 1) "" "s") name
                 (if ignored
                     (format "; ignored %d non-file entr%s"
                             (length ignored)
                             (if (= (length ignored) 1) "y" "ies"))
                   ""))))))

(defun my-file-group-remove-files (name files)
  "Remove FILES from the file group NAME."
  (interactive
   (let* ((name (my-file-group--read-name "Remove from group: "))
          (entry (my-file-group--entry name))
          (files (cdr entry)))
     (unless files
       (user-error "File group is empty: %s" name))
     (list name
           (completing-read-multiple "Remove file(s): " files nil t))))
  (let ((entry (my-file-group--entry name)))
    (unless entry
      (user-error "Unknown file group: %s" name))
    (unless files
      (user-error "No files selected"))
    (let ((remaining (copy-sequence (cdr entry)))
          (removed 0))
      (dolist (file files)
        (when (member file remaining)
          (setq remaining (delete file remaining))
          (setq removed (1+ removed))))
      (when (zerop removed)
        (user-error "None of the selected files belong to %s" name))
      (setcdr entry remaining)
      (my-file-group--save)
      (message "Removed %d file%s from %s"
               removed (if (= removed 1) "" "s") name))))

(defun my-file-group-delete (name)
  "Delete the file group NAME without changing the current windows."
  (interactive (list (my-file-group--read-name "Delete group: ")))
  (let ((entry (my-file-group--entry name)))
    (unless entry
      (user-error "Unknown file group: %s" name))
    (when (y-or-n-p (format "Delete file group %s? " name))
      (setq my-file-groups (delete entry my-file-groups))
      (my-file-group--save)
      (message "Deleted file group: %s" name))))

(defun my-file-group--load-buffers (name)
  "Load readable files from group NAME and return their buffers."
  (let* ((entry (my-file-group--entry name))
         (files (and entry (my-file-group--deduplicate (cdr entry))))
         buffers skipped)
    (unless entry
      (user-error "Unknown file group: %s" name))
    (unless files
      (user-error "File group is empty: %s" name))
    (dolist (file files)
      (condition-case err
          (let ((expanded (expand-file-name file)))
            (if (file-regular-p expanded)
                (push (find-file-noselect expanded) buffers)
              (push (cons file "not a regular file") skipped)))
        (error
         (push (cons file (error-message-string err)) skipped))))
    (setq buffers (nreverse buffers)
          skipped (nreverse skipped))
    (when skipped
      (display-warning
       'my-file-groups
       (format "Skipped files in %s:\n%s"
               name
               (mapconcat (lambda (item)
                            (format "  %s: %s" (car item) (cdr item)))
                          skipped "\n"))
       :warning))
    (unless buffers
      (user-error "File group has no readable regular files: %s" name))
    buffers))

(defun my-file-group--check-capacity (count)
  "Signal an error unless COUNT side-by-side windows fit this frame."
  (let* ((minimum (max 1 window-min-width))
         (available (frame-width))
         (required (* count minimum)))
    (when (> required available)
      (user-error
       "Cannot show %d files side by side: need %d columns, frame has %d"
       count required available))))

(defun my-file-group--main-window ()
  "Return a live non-side window in the selected frame."
  (or (catch 'window
        (dolist (window (window-list nil 'nomini))
          (unless (window-parameter window 'window-side)
            (throw 'window window))))
      (selected-window)))

(defun my-file-group--install-layout (buffers)
  "Replace the current tab layout with side-by-side BUFFERS."
  (let ((old-state (window-state-get (frame-root-window) t))
        first-window)
    (condition-case err
        (progn
          (let ((main-window (my-file-group--main-window))
                (ignore-window-parameters t))
            (select-window main-window)
            (set-window-dedicated-p main-window nil)
            (delete-other-windows main-window))
          (setq first-window (selected-window))
          (set-window-buffer first-window (car buffers))
          (let ((window first-window)
                (remaining (length buffers)))
            (dolist (buffer (cdr buffers))
              (let* ((size (/ (window-total-width window) remaining))
                     (new-window
                      (with-selected-window window
                        (split-window-right size))))
                (setq remaining (1- remaining)
                      window new-window)
                (set-window-buffer window buffer))))
          (balance-windows-area)
          (select-window first-window))
      (error
       (ignore-errors
         (window-state-put old-state (frame-root-window) 'safe))
       (signal (car err) (cdr err))))))

(defun my-file-group-rebuild (name)
  "Rebuild the current frame layout from file group NAME."
  (interactive (list (my-file-group--read-name "Rebuild group: ")))
  (let ((buffers (my-file-group--load-buffers name)))
    (my-file-group--check-capacity (length buffers))
    (my-file-group--install-layout buffers)
    (message "Opened file group: %s" name)))

(defun my-file-group-open (name)
  "Open NAME by rebuilding the current frame's window layout."
  (interactive (list (my-file-group--read-name "Open group: ")))
  (unless (my-file-group--entry name)
    (user-error "Unknown file group: %s" name))
  (my-file-group-rebuild name))

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

  (defun my-dirvish-side-close-after-open ()
    "Close the visible Dirvish sidebar after opening a file."
    (when-let* ((window (dirvish-side--session-visible-p)))
      (delete-window window)))

  (setq dirvish-side-open-file-action
        #'my-dirvish-side-close-after-open)

  (run-with-idle-timer
   1 nil
   (lambda ()
     (require 'dirvish-icons)
     (require 'nerd-icons)
     (require 'vc-git)
     (require 'recentf)))

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
