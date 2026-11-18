;;; screenshot.el --- Render the flatui-dark theme to a PNG -*- lexical-binding: t -*-

;; Regenerate the README screenshot after a color change.
;;
;; Requires a Cairo build of Emacs (has `x-export-frames') and a virtual
;; display.  On Linux, run under Xvfb:
;;
;;   xvfb-run -a -s "-screen 0 1024x768x24" \
;;     emacs -Q -L <modus-themes-dir> --load tools/screenshot.el
;;
;; `<modus-themes-dir>' is the directory containing `modus-themes.el'
;; (e.g. `~/.emacs.d/elpa/modus-themes-<ver>/'); the theme requires it.
;;
;; Writes `screenshot1.png' next to the repo root (this file's parent dir).

;;; Code:

;; Clean, distraction-free frame.
(setq inhibit-startup-screen t
      enable-local-variables nil
      enable-dir-local-variables nil)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq-default cursor-type nil)

;; Fixed font and frame size so every render is identical.
;; Tweak these to change the look of the screenshot.
(setq flatui-dark-screenshot-font-family "DejaVu Sans Mono"
      flatui-dark-screenshot-font-height 140
      flatui-dark-screenshot-rows 30
      flatui-dark-screenshot-cols 96)

(let* ((script-dir (file-name-directory load-file-name))
       (root (expand-file-name ".." script-dir))
       (theme-file (expand-file-name "flatui-dark-theme.el" root))
       (sample-file (expand-file-name "sample.el" script-dir))
       (out-file (expand-file-name "screenshot1.png" root)))
  (set-face-attribute 'default nil
                      :family flatui-dark-screenshot-font-family
                      :height flatui-dark-screenshot-font-height)

  ;; load-theme searches custom-theme-load-path, not load-path.
  (add-to-list 'custom-theme-load-path root)
  (let ((load-suppress-message t))
    (load theme-file))
  (load-theme 'flatui-dark t)

  (find-file sample-file)
  (set-frame-size (selected-frame) flatui-dark-screenshot-cols
                  flatui-dark-screenshot-rows)
  (redraw-display) ;; avoid a stray-glyph redisplay artifact at the top
  (message "") ;; clear the echo area so no load message is captured

  (with-temp-file out-file
    (insert (x-export-frames nil 'png)))
  (message "Wrote %s" out-file)
  (kill-emacs 0))
