;;; .emacs --- Rogério Brito's Emacs configuration file
;;
;; Author: Rogério Brito
;; Copyright 2000-2009  Rogério Brito
;; Keywords: configuration, .emacs
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;; 
;;; History:
;;
;; Made sure to use M-x checkdoc on the file, to get minor documentation
;; problems ironed out.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Configuration of the keyboard.
(global-set-key "\C-h" 'delete-backward-char)
;(global-set-key "\177" 'delete-char)
(global-unset-key [backspace] )
(global-set-key [backspace] 'delete-backward-char)
(global-unset-key [delete] )
(global-set-key [delete] 'delete-char)
;(global-set-key [f6] (kbd "C-h C-c C-c"))

(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
    	 (change (if (string= dic "brasileiro") "american" "brasileiro")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))

(global-set-key (kbd "<f8>")   'fd-switch-dictionary)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Required packages
(require 'tex-site)
(require 'reftex)
(require 'post)
(require 'compile)
(require 'cc-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auxiliary functions

(defun c-n-cpp-environment () "Standard configuration for C/C++ modes."
  (c-set-style "K&R")
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 8)
  (setq-default show-trailing-whitespace t))

(defun my-text-environment () "Standard configuration for text modes."
  (auto-fill-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Defines some handy hooks
(add-hook 'fundamental-hook	'iso-accents-mode)
(add-hook 'text-mode-hook	'my-text-environment)
(add-hook 'c-mode-hook		'c-n-cpp-environment)
(add-hook 'c++-mode-hook	'c-n-cpp-environment)

(add-hook 'dired-load-hook	(lambda () (load "dired-x")))
(add-hook 'dired-mode-hook	(lambda ()))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General settings
(setq inhibit-startup-message t); remove splash screen
(setq initial-scratch-message nil)	; makes initial scratch buffer empty
(global-font-lock-mode t)	; turns on syntax highlighting
(column-number-mode t)		; turns on column number
(tool-bar-mode -1)		; disables annoying toolbar
(show-paren-mode t)		; shows matching parenthesis
(fset 'yes-or-no-p 'y-or-n-p)	; asks shorter answers
(transient-mark-mode t)		; makes selected area visible

(setq-default font-lock-auto-fontify t
              font-lock-use-colors '(color)
              font-lock-maximum-decoration t
              font-lock-maximum-size 524000)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/"))

;; Experimental settings
;
; (write-region-inhibit-fsync t); disables fsync (for laptops)
; (recentf-mode)		; shows recently used files
; (recentf-save-file "~/.emacs.d/recentf")
; (setq mouse-autoselect-window t); jumps to the selected window
; (require-final-newline t)	; makes sure that files are newline terminated

(custom-set-variables
 '(LaTeX-item-indent 0)
 '(TeX-source-correlate-method (quote source-specials))
 '(TeX-source-correlate-start-server t)
 '(case-fold-search t)
 '(dired-recursive-delete t)
 '(ecb-layout-window-sizes nil)
 '(fill-column 76)
 '(nxml-sexp-element-flag t)
 '(post-kill-quoted-sig nil)
 '(post-uses-fill-mode nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Encoding settings

(prefer-coding-system 'utf-8)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Hack to ease compilation of small C programs (from www.emacswiki.org)
(add-hook 'c-mode-hook
	  (lambda ()
	    (unless (file-exists-p "Makefile")
	      (set (make-local-variable 'compile-command)
		   (let ((file (file-name-nondirectory buffer-file-name)))
		     (concat "gcc -O2 -Wall -ansi -pedantic -o "
			     (file-name-sans-extension file) " " file))))))

(add-hook 'c++-mode-hook
	  (lambda ()
	    (unless (file-exists-p "Makefile")
	      (set (make-local-variable 'compile-command)
		   (let ((file (file-name-nondirectory buffer-file-name)))
		     (concat "g++ -O2 -Wall -ansi -pedantic -o "
			     (file-name-sans-extension file) " " file))))))

;; For AUCTeX
(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (outline-minor-mode)
	    (reftex-mode)
	    (setq reftex-plug-into-AUCTeX t)))

; to avoid clash with prefix of auctex
(setq outline-minor-mode-prefix "\C-c\C-o")
; (setq-default TeX-master nil)	; Query for master file.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(org-remember-insinuate)

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)

(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; ; Taken from:
;; ; http://blog.iany.me/2009/07/pretty-emacs-diff-mode/
;; (custom-set-faces
;;  '(diff-added ((t (:foreground "#00ff00"))))
;;  '(diff-context ((t nil)))
;;  '(diff-file-header ((((class color) (min-colors 88) (background dark)) (:foreground "RoyalBlue1"))))
;;  '(diff-function ((t (:foreground "#00bbdd"))))
;;  '(diff-header ((((class color) (min-colors 88) (background dark)) (:foreground "RoyalBlue1"))))
;;  '(diff-hunk-header ((t (:foreground "#fbde2d"))))
;;  '(diff-nonexistent ((t (:inherit diff-file-header :strike-through nil))))
;;  '(diff-refine-change ((((class color) (min-colors 88) (background dark)) (:background "#182042"))))
;;  '(diff-removed ((t (:foreground "#ff0000")))))

; Shorter:
; http://stackoverflow.com/questions/1877103/how-can-i-get-more-colors-in-emacs-vc-diff
(custom-set-faces
 '(diff-added ((t (:foreground "Green"))) t)
 '(diff-removed ((t (:foreground "Red"))) t)
 )
