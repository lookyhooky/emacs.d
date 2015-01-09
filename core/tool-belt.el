;;; tool-belt.el --- a utility belt of Emacs

;;; Commentary:

;; This file provides a set of utility functions for Foundation.

;;; Code:
(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is not-nil, the available packages lust will not be
re-downloaded in order to locate PACKAGE."
  (unless (package-installed-p package min-version)
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (package-refresh-contents)
      (require-package package min-version t))))

(defun add-subfolders-to-load-path (parent-dir)
  "Add all PARENT-DIR subdirs to the `load-path'."
  (dolist (f (directory-files parent-dir))
    (let ((name (expand-file-name f parent-dir)))
      (when (and (file-directory-p name)
                 (not (string-prefix-p "." f)))
        (add-to-list 'load-path name)
        (add-subfolders-to-load-path name)))))

(defun add-auto-mode (mode &rest patterns)
  "Add entries to `auto-mode-alist' to use MODE for all given file PATTERNS."
  (dolist (pattern patterns)
    (add-to-list 'auto-mode-alist (cons pattern mode))))

(provide 'tool-belt)

;;; tool-belt.el ends here