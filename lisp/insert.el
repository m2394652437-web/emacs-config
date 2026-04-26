;;rime 
(use-package rime
  :custom
  (rime-user-data-dir "~/.local/share/fcitx5/rime"))
(setq rime-show-candidate 'posframe) 
(setq default-input-method "rime")
;;end rime

;; auto-capitalize-mode
(defvar auto-capitalize-mode nil)
  "自动大写模式"
(defun capitalize-last-word ()
  "大写前一个单词的首字母，保留其余字母原有大小写。
不处理以 . 或 / 开头的单词。"
  (when auto-capitalize-mode
    (save-excursion
      ;; 从当前位置（标点/空格后）向后跳过非单词字符，定位到单词开头
      (skip-syntax-backward "^w")  ; 跳过所有非单词字符（空格、标点等）
      (skip-syntax-backward "w")   ; 跳到单词开头
      (let ((word-start (point)))
        (when (looking-at "\\w")  ; 确认当前位置是单词字符
          ;; 新增：检查单词前一个字符是否是 . 或 /
          (let ((prev-char (if (> word-start 1)
                               (buffer-substring (1- word-start) word-start)
                             ""))
                ;; 修复核心：先提取首字符并保存，再操作
                (first-char (buffer-substring word-start (1+ word-start))))
            (unless (or (string-empty-p prev-char)
                        (member prev-char '("." "/")))  ; 排除 . 和 / 开头的情况
              ;; 正确逻辑：先删原字符，再插入大写后的首字符
              (delete-region word-start (1+ word-start))
              (insert (upcase first-char)))))))))

(defun auto-capitalize-post-self-insert ()
  "在输入指定标点/符号后自动大写前一个单词。"
  (when (and auto-capitalize-mode
             ;; 完整的触发字符列表：空格、连字符、各种标点、换行
             (memq last-command-event 
                   '(? ?. ?- ?! ?? ?, ?\; ?: ?\) ?\] ?\} ?\n ?\: ?\?)))
    (capitalize-last-word)))

(defun toggle-auto-capitalize-mode ()
  "切换自动大写模式。"
  (interactive)
  (setq auto-capitalize-mode (not auto-capitalize-mode))
  (if auto-capitalize-mode
      (add-hook 'post-self-insert-hook 'auto-capitalize-post-self-insert)
    (remove-hook 'post-self-insert-hook 'auto-capitalize-post-self-insert))
  (message "auto-capitalize-mode %s" (if auto-capitalize-mode "on" "off")))

(global-set-key (kbd "C-c c") 'toggle-auto-capitalize-mode)
;;end auto capitalize mode

;;+1
(defun my/increment-number-at-point ()
  "add 1 to number at cursor"
  (interactive)
  (let ((bounds (bounds-of-thing-at-point 'number)))
    (if bounds
        (let* ((beg (car bounds))
               (end (cdr bounds))
               (num-str (buffer-substring-no-properties beg end))
               (num (string-to-number num-str)))
          (delete-region beg end)
          (insert (number-to-string (1+ num))))
      (message "No number found at cursor"))))
(global-set-key (kbd "C-+") 'my/increment-number-at-point)
;;end +1

(provide 'insert)

