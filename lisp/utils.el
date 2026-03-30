(defun call-with-auto-input (function &rest values)
  "按顺序自动将参数输入对应函数"
  (let ((index 0)
        (value-list values))
    (cl-letf (((symbol-function 'read-string)
               (lambda (prompt &optional initial-input history default-value inherit-input-method)
                 (if (< index (length value-list))
                     (prog1
                         (nth index value-list)
                       (cl-incf index))
                   initial-input))))
      (call-interactively function))))

(provide 'utils)
