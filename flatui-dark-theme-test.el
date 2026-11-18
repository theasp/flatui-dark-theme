;;; flatui-dark-theme-test.el --- Tests for the flatui-dark theme -*- lexical-binding: t -*-

;; Tests for the flatui-dark theme, built on the modus-themes engine.
;; Follows the test patterns from modus-themes' own test suite
;; (tests/modus-themes-test.el).
;;
;; Run with:
;;   emacs --batch -L <modus-themes-dir> -l flatui-dark-theme-test.el \
;;     --eval "(ert-run-tests-batch-and-exit)"

;;; Code:

(require 'ert)
(require 'custom)
(require 'modus-themes)

;; Resolve the theme file relative to this test file's directory.
(defconst flatui-dark-theme-test-dir
  (file-name-directory (or load-file-name buffer-file-name))
  "Directory containing the theme file under test.")

(defun flatui-dark-theme-test--load-theme ()
  "Load and activate the flatui-dark theme, returning the previous theme list."
  (let ((prev custom-enabled-themes))
    (load (expand-file-name "flatui-dark-theme.el" flatui-dark-theme-test-dir))
    (load-theme 'flatui-dark t)
    prev))

(ert-deftest flatui-dark-theme-activates ()
  "The theme loads and activates without error."
  (let ((prev (flatui-dark-theme-test--load-theme)))
    (unwind-protect
        (should (member 'flatui-dark custom-enabled-themes))
      (when prev (load-theme (car prev) t)))))

(ert-deftest flatui-dark-theme-registered ()
  "The theme is registered in modus-themes-registered-items."
  (load (expand-file-name "flatui-dark-theme.el" flatui-dark-theme-test-dir))
  (should (member 'flatui-dark modus-themes-registered-items)))

(ert-deftest flatui-dark-theme-inheritance ()
  "All faces inherit from valid faces (no dangling :inherit references)."
  (let ((prev (flatui-dark-theme-test--load-theme)))
    (unwind-protect
        (should-not
         (seq-filter
          (lambda (face)
            (if-let* ((parent (face-attribute face :inherit)))
                (and (symbolp parent)
                     (not (eq parent 'unspecified))
                     (not (facep parent)))))
          (face-list)))
      (when prev (load-theme (car prev) t)))))

(ert-deftest flatui-dark-theme-palette-complete ()
  "The core palette contains the FlatUI color entries."
  (load (expand-file-name "flatui-dark-theme.el" flatui-dark-theme-test-dir))
  (let ((pal (symbol-value 'flatui-dark-modus-palette)))
    (dolist (key '(bg-main bg-dim fg-main fg-dim fg-alt
                    bg-active bg-inactive border
                    red green yellow blue magenta
                    fg-heading-1 fg-heading-8))
      (should (assoc key pal)))))

(provide 'flatui-dark-theme-test)
;;; flatui-dark-theme-test.el ends here
