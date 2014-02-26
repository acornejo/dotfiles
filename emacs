;; disable splash sceen
(setq inhibit-splash-screen t)
;; set size
(if (window-system) (set-frame-height (selected-frame) 82) (set-frame-width (selected-frame) 82))
;; use y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)
;; delete whole line when at beginning
(setq-default kill-whole-line t)
;; convert tabs to spaces
(setq-default indent-tabs-mode nil)
;; use 4 spaces per tab
(setq-default tab-width 4)
;; Switch to use for directory listings
(setq dired-listing-switches "-l")
(setq list-directory-brief-switches "-l")
;; Hide menu bar
(menu-bar-mode nil)
;; Hide toolbar
(tool-bar-mode nil)
;; Hide scrollbar
(scroll-bar-mode nil)
;; Show line and column numbers
(line-number-mode 1)
(column-number-mode 1)
;; Highlight current line
(global-hl-line-mode 1)
;; Turn on auto-fill for text files
(add-hook 'text-mode-hook 'turn-on-auto-fill)
;; Set column size
(setq-default fill-column 78)
;; Save backups to another directory
(setq make-backup-files t)
(setq version-control t)
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backups"))))
(setq delete-old-versions t)
;; Show matching paren
(show-paren-mode t)
(setq show-paren-style 'parentheses)
;; Show colors in shell
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; Change ugly font
;;(set-default-font "9x15")
;; Color theme
;;(load "~/.emacs.d/theme.el" nil t t)
;; recentf stuff
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; **** AUCTEX & PREVIEW ****
;; Load auctex
;;(load "auctex.el" nil t t)
(setq TeX-auto-save nil)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
;; Load preview
;;(load "preview-latex.el" nil t t)
(setq preview-auto-cache-preamble t)
(add-hook 'LaTeX-mode-hook 'LaTeX-install-toolbar)
;; Load reftex
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'latex-mode-hook 'turn-on-reftex)
(setq reftex-enable-partial-scans t)
(setq reftex-save-parse-info t)
(setq reftex-use-multiple-selection-buffers t)
(setq reftex-vref-is-default t)
;; Reindent on newline
(custom-set-variables
 '(global-font-lock-mode t nil (font-lock))
 '(TeX-PDF-mode t)
 '(TeX-newline-function (quote reindent-then-newline-and-indent))
)
(setq tex-command "pdftex")
;; Use evince instead of xpdf/xdvi
(eval-after-load "tex"
  '(setcdr (assoc "View" TeX-command-list)
          '("evince -w %o"
            TeX-run-command nil t :help "Run evince with ...")))
;; Spelling
(add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'tex-mode-hook 'flyspell-mode)
(add-hook 'bibtex-mode-hook 'flyspell-mode)
