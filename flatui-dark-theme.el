;;; flatui-dark-theme.el --- FlatUI dark theme built on the modus-themes engine -*- lexical-binding: t -*-

;; Author: Andrew Phillips <theasp@gmail.com>
;; Keywords: faces theme flatui modus
;; URL: https://github.com/theasp/flatui-dark-theme
;; Package-Requires: ((emacs "29.1") (modus-themes "5.0.0"))

;; This is an experimental derivative of the `flatui-dark' theme, rebuilt on
;; the modus-themes engine instead of the raw `deftheme'/`custom-theme-set-faces'
;; API.  It declares a complete FlatUI palette and lets the engine generate its
;; full face set from it.  It requires modus-themes >= 5.0.0 (the version that
;; provides the theme-building API `modus-themes-theme').
;;
;; Difference from the original: the original's niche per-mode faces (web-mode,
;; gnus, erc, helm, magit, org, etc.) are not ported; the engine's own face set
;; is used and colored by the palette.

(require 'modus-themes)

(defconst flatui-dark-modus-palette
  (append
   '(
     ;; Basic values
     (bg-main          "#000000")
     (bg-dim           "#2c3e50")
     (fg-main          "#bdc3c7")
     (fg-dim           "#7f8c8d")
     (fg-alt           "#95a5a6")
     (bg-active        "#34495e")
     (bg-inactive      "#2c3e50")
     (border           "#7f8c8d")

     ;; Common accent foregrounds
     (red             "#e74c3c")
     (red-warmer      "#e67e22")
     (red-cooler      "#e74c3c")
     (red-faint       "#c0392b")
     (red-intense     "#e74c3c")
     (green           "#2ecc71")
     (green-warmer    "#2ecc71")
     (green-cooler    "#27ae60")
     (green-faint     "#27ae60")
     (green-intense   "#2ecc71")
     (yellow          "#f1c40f")
     (yellow-warmer   "#f39c12")
     (yellow-cooler   "#f1c40f")
     (yellow-faint    "#f39c12")
     (yellow-intense  "#f1c40f")
     (blue            "#3498db")
     (blue-warmer     "#3498db")
     (blue-cooler     "#2980b9")
     (blue-faint      "#2980b9")
     (blue-intense    "#3498db")
     (magenta         "#9b59b6")
     (magenta-warmer  "#9b59b6")
     (magenta-cooler  "#8e44ad")
     (magenta-faint   "#8e44ad")
     (magenta-intense "#9b59b6")
     (cyan            "#1abc9c")
     (cyan-warmer     "#1abc9c")
     (cyan-cooler     "#16a085")
     (cyan-faint      "#16a085")
     (cyan-intense    "#1abc9c")

     ;; Uncommon accent foregrounds
     (rust   "#d35400")
     (gold   "#f39c12")
     (olive  "#27ae60")
     (slate  "#2980b9")
     (indigo "#8e44ad")
     (maroon "#c0392b")
     (pink   "#9b59b6")

     ;; Common accent backgrounds
     (bg-red-intense     "#c0392b")
     (bg-green-intense   "#27ae60")
     (bg-yellow-intense  "#f39c12")
     (bg-blue-intense    "#2980b9")
     (bg-magenta-intense "#8e44ad")
     (bg-cyan-intense    "#16a085")
     (bg-red-subtle      "#c0392b")
     (bg-green-subtle    "#27ae60")
     (bg-yellow-subtle   "#f39c12")
     (bg-blue-subtle     "#2980b9")
     (bg-magenta-subtle  "#8e44ad")
     (bg-cyan-subtle     "#16a085")
     (bg-red-nuanced     "#c0392b")
     (bg-green-nuanced   "#27ae60")
     (bg-yellow-nuanced  "#f39c12")
     (bg-blue-nuanced    "#2980b9")
     (bg-magenta-nuanced "#8e44ad")
     (bg-cyan-nuanced    "#16a085")

     ;; Uncommon accent background and foreground pairs
     (bg-clay     "#c0392b")
     (fg-clay     "#e74c3c")
     (bg-ochre    "#f39c12")
     (fg-ochre    "#f1c40f")
     (bg-lavender "#8e44ad")
     (fg-lavender "#9b59b6")
     (bg-sage     "#27ae60")
     (fg-sage     "#2ecc71")

     ;; Graphs
     (bg-graph-red-0     "#e74c3c")
     (bg-graph-red-1     "#c0392b")
     (bg-graph-green-0   "#2ecc71")
     (bg-graph-green-1   "#27ae60")
     (bg-graph-yellow-0  "#f1c40f")
     (bg-graph-yellow-1  "#f39c12")
     (bg-graph-blue-0    "#3498db")
     (bg-graph-blue-1    "#2980b9")
     (bg-graph-magenta-0 "#9b59b6")
     (bg-graph-magenta-1 "#8e44ad")
     (bg-graph-cyan-0    "#1abc9c")
     (bg-graph-cyan-1    "#16a085")

     ;; Special purpose
     (bg-completion       "#34495e")
     (bg-popup            "#2c3e50")
     (bg-hover            "#34495e")
     (bg-hover-secondary  "#2c3e50")
     (bg-hl-line          "#2c3e50")
     (bg-region           "#34495e")
     (bg-mode-line-active        "#bdc3c7")
     (fg-mode-line-active        "#000000")
     (border-mode-line-active    "#34495e")
     (bg-mode-line-inactive      "#7f8c8d")
     (fg-mode-line-inactive      "#2c3e50")
     (border-mode-line-inactive  "#7f8c8d")
     (modeline-err     "#e74c3c")
     (modeline-warning "#f39c12")
     (modeline-info    "#1abc9c")
     (bg-tab-bar      "#2c3e50")
     (bg-tab-current  "#000000")
     (bg-tab-other    "#34495e")

     ;; Diffs
     (bg-added           "#27ae60")
     (bg-added-faint     "#27ae60")
     (bg-added-refine    "#27ae60")
     (bg-added-fringe    "#27ae60")
     (fg-added           "#2ecc71")
     (fg-added-intense   "#2ecc71")
     (bg-changed         "#f39c12")
     (bg-changed-faint   "#f39c12")
     (bg-changed-refine  "#f39c12")
     (bg-changed-fringe  "#f39c12")
     (fg-changed         "#f1c40f")
     (fg-changed-intense "#f1c40f")
     (bg-removed         "#c0392b")
     (bg-removed-faint   "#c0392b")
     (bg-removed-refine  "#c0392b")
     (bg-removed-fringe  "#c0392b")
     (fg-removed         "#e74c3c")
     (fg-removed-intense "#e74c3c")
     (bg-diff-context    "#2c3e50")

     ;; Paren match
     (bg-paren-match      "#34495e")
     (bg-paren-expression "#2c3e50")

     ;; General mappings
     (cursor            "#95a5a6")
     (keybind           "#2980b9")
     (name              "#9b59b6")
     (identifier        "#f1c40f")
     (err               "#c0392b")
     (warning           "#f39c12")
     (info              "#1abc9c")
     (underline-err     "#e74c3c")
     (underline-warning "#f1c40f")
     (underline-note    "#1abc9c")
     (bg-prominent-err      "#c0392b")
     (fg-prominent-err      "#ffffff")
     (bg-prominent-warning  "#f39c12")
     (fg-prominent-warning  "#000000")
     (bg-prominent-note     "#16a085")
     (fg-prominent-note     "#ffffff")
     (bg-active-argument    "#2c3e50")
     (fg-active-argument    "#f1c40f")
     (bg-active-value       "#2c3e50")
     (fg-active-value       "#1abc9c")

     ;; Code mappings
     (builtin        "#e67e22")
     (comment        "#f1c40f")
     (constant       "#1abc9c")
     (docstring      "#e67e22")
     (fnname         "#3498db")
     (fnname-call    "#3498db")
     (keyword        "#9b59b6")
     (preprocessor   "#8e44ad")
     (property       "#1abc9c")
     (rx-backslash   "#8e44ad")
     (rx-construct   "#9b59b6")
     (string         "#f1c40f")
     (type           "#2980b9")
     (variable       "#f1c40f")
     (variable-use   "#f1c40f")

     ;; Accent mappings
     (accent-0 "#3498db")
     (accent-1 "#9b59b6")
     (accent-2 "#1abc9c")
     (accent-3 "#f1c40f")

     ;; Completion mappings
     (fg-completion-match-0 "#3498db")
     (fg-completion-match-1 "#9b59b6")
     (fg-completion-match-2 "#1abc9c")
     (fg-completion-match-3 "#f1c40f")

     ;; Date mappings
     (date-common           "#1abc9c")
     (date-deadline         "#e74c3c")
     (date-deadline-subtle  "#c0392b")
     (date-event            "#95a5a6")
     (date-holiday          "#9b59b6")
     (date-holiday-other    "#3498db")
     (date-range            "#95a5a6")
     (date-scheduled        "#f39c12")
     (date-scheduled-subtle "#f1c40f")
     (date-weekday          "#1abc9c")
     (date-weekend          "#9b59b6")

     ;; Link mappings
     (fg-link              "#1abc9c")
     (underline-link       "#1abc9c")
     (fg-link-symbolic     "#1abc9c")
     (underline-link-symbolic "#1abc9c")
     (fg-link-visited      "#9b59b6")
     (underline-link-visited "#9b59b6")

     ;; Mail mappings
     (mail-cite-0     "#3498db")
     (mail-cite-1     "#f39c12")
     (mail-cite-2     "#1abc9c")
     (mail-cite-3     "#e74c3c")
     (mail-part       "#3498db")
     (mail-recipient  "#8e44ad")
     (mail-subject    "#9b59b6")
     (mail-other      "#8e44ad")

     ;; Mark mappings
     (bg-mark-delete "#c0392b")
     (fg-mark-delete "#e74c3c")
     (bg-mark-select "#16a085")
     (fg-mark-select "#1abc9c")
     (bg-mark-other  "#f39c12")
     (fg-mark-other  "#f1c40f")

     ;; Prompt mappings
     (fg-prompt "#1abc9c")

     ;; Prose mappings
     (fg-prose-code        "#1abc9c")
     (fg-prose-macro       "#8e44ad")
     (fg-prose-verbatim    "#9b59b6")
     (prose-done           "#2ecc71")
     (prose-todo            "#e74c3c")
     (prose-metadata       "#7f8c8d")
     (prose-metadata-value "#95a5a6")
     (prose-table          "#95a5a6")
     (prose-table-formula  "#9b59b6")
     (prose-tag            "#8e44ad")

     ;; Rainbow mappings
     (rainbow-0 "#bdc3c7")
     (rainbow-1 "#c0392b")
     (rainbow-2 "#1abc9c")
     (rainbow-3 "#e67e22")
     (rainbow-4 "#f1c40f")
     (rainbow-5 "#8e44ad")
     (rainbow-6 "#2ecc71")
     (rainbow-7 "#3498db")
     (rainbow-8 "#9b59b6")

     ;; Search mappings
     (bg-search-current    "#f39c12")
     (bg-search-lazy       "#16a085")
     (bg-search-static     "#8e44ad")
     (bg-search-replace    "#c0392b")
     (bg-search-rx-group-0 "#2980b9")
     (bg-search-rx-group-1 "#27ae60")
     (bg-search-rx-group-2 "#c0392b")
     (bg-search-rx-group-3 "#8e44ad")

     ;; Heading mappings
     (fg-heading-0 "#1abc9c")
     (fg-heading-1 "#bdc3c7")
     (fg-heading-2 "#f1c40f")
     (fg-heading-3 "#2980b9")
     (fg-heading-4 "#9b59b6")
     (fg-heading-5 "#27ae60")
     (fg-heading-6 "#c0392b")
     (fg-heading-7 "#16a085")
     (fg-heading-8 "#7f8c8d"))
   modus-themes-common-palette-mappings)
  "Complete FlatUI dark palette for the modus-themes engine.
Named colors are (COLOR-NAME HEX-VALUE); the trailing
`modus-themes-common-palette-mappings' supplies the default semantic
mappings. Every key the engine's face list references is present so
no face degrades to `unspecified'.")

(defcustom flatui-dark-modus-palette-user nil
  "Like the `flatui-dark-modus-palette' for user-defined entries.
This is meant to extend the palette with custom named colors and/or
semantic palette mappings.  Those may then be used in combination with
palette overrides (also see `flatui-dark-modus-palette-overrides')."
  :group 'modus-themes
  :type '(repeat (list symbol (choice symbol string))))

(defcustom flatui-dark-modus-palette-overrides nil
  "Overrides for `flatui-dark-modus-palette'.
Mirror the elements of the aforementioned palette, overriding their
value.  Theme-specific overrides take precedence over shared
overrides."
  :group 'modus-themes
  :type '(repeat (list symbol (choice symbol string))))

(modus-themes-theme
 'flatui-dark
 'flatui-dark-modus
 "FlatUI dark color theme, rebuilt on the modus-themes engine."
 'dark
 'flatui-dark-modus-palette
 'flatui-dark-modus-palette-user
 'flatui-dark-modus-palette-overrides)

(provide 'flatui-dark-theme)

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

;;; flatui-dark-theme.el ends here
