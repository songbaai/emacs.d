;#####################################################################
; .emacs
;
; Emacs 21 configuration file
; PhysBAM Default .emacs
; Based on Andrew Selle (aselle@graphics.stanford.edu)
; Based on Nick Rasmussen's (nick@jive.org)
; Based on Jim Hourihan's (jimh@lucasdigital.com)
;
;#####################################################################

(require 'cc-mode)
(setq speedbar-use-imenu-flag 't)

; mouse dragging
(require 'mouse-drag)
(global-set-key [down-mouse-2] 'mouse-drag-drag)

;
; First some global color and font setup...
;
; Menu colors and fonts are in .Xdefaults, being lucid widgets
; rather than emacs-controlled items.
;
(setq default-frame-alist
      '(                   ;  
                                        ;        (font             .  "")
        (width            .     80 )
        (height           .     50 )
        (mouse-color      . "White")
        (cursor-color     .  "Blue")
        (foreground-color . "White")
        (background-color . "Black")))

;; Make the modeline a little more inconspicuous...
;; (set-face-background 'modeline "#202020")
;; (set-face-foreground 'modeline "#C0C0C0")


;; Make all tabs spaces by default
;;(setq-default indent-tabs-mode nil)

;; Set up the mode-specific font locking
;;(global-font-lock-mode t nil)
(setq font-lock-maximum-decoration t)

; Set the modes for various types of files
(setq auto-mode-alist
      (append
       (list
        '("\\.C$"         . c++-mode)
        '("\\.h$"         . c++-mode)
        '("\\.c\\+\\+$"   . c++-mode)
        '("\\.H$"         . c++-mode)
        '("\\.el$"        . emacs-lisp-mode)
        '("emacs$"        . emacs-lisp-mode)
        '("\\.tar$"       . tar-mode)
        '("make\\.log\\~" . compilation-mode)
        '("Makefile$"     . makefile-mode)
        '("Makefile.*"    . makefile-mode)
        '("SConstruct"    . python-mode)
        '("SConscript"    . python-mode))
       auto-mode-alist))


(make-face            'nick-url-face)
(set-face-foreground  'nick-url-face "Blue")
(set-face-underline-p 'nick-url-face t)
(scroll-bar-mode -1)
(tool-bar-mode)
;;(global-set-key [mouse-4] 'scroll-down)
;;(global-set-key [mouse-5] 'scroll-up)

;------------------------------------------------------------------------------
;
; Hooks, hooks, and more hooks
;
;;(defconst text-mode-hook 
;;  '(lambda ()
;;     (defconst fill-column 80)
;;     (defconst tab-stop-list 
;;       (list 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))
;;     (auto-fill-mode 0)
;;     (transient-mark-mode 1)))

(defconst shell-mode-hook
  '(lambda ()
     (defconst comint-scroll-show-maximum-output 't)
     (defconst comint-scroll-to-bottom-on-input 't)
     (defconst comint-scroll-show-maximum-output 't)
     (defconst comint-output-filter-functions
       '(comint-postoutput-scroll-to-bottom comint-strip-ctrl-m))))

(defconst ediff-startup-hook
  '(lambda ()
;     (ediff-toggle-wide-display)
     (ediff-toggle-split)))

(defconst makefile-mode-hook
  '(lambda ()
     (run-hooks 'text-mode-hook)
     (set-face-background 'makefile-tab-face "grey70")))

(defconst latex-mode-hook
  '(lambda ()
     (run-hooks 'text-mode-hook)
     (defconst fill-column 80)
     (auto-fill-mode 0)))

(setq auto-mode-alist (cons '("\\.tex$" . latex-mode) auto-mode-alist))

; tex stuff
(setq tex-dvi-view-command "xdvi")

;(global-font-lock-mode t nil)
(setq-default font-lock-maximum-decoration t)
; (setq font-lock-support-mode 'lazy-lock-mode)
(setq lazy-lock-stealth-time nil)
(setq lazy-lock-stealth-lines 1000)

(setq scroll-preserve-screen-position nil)

;#####################################################################
; PhysBAM stuff
;####################################################################
(setq physbam-use-scons t)
(load-file (format "~/.emacs.d/physbam.el" (getenv "PHYSBAM"))) 

; (setq font-lock-support-mode 'lazy-lock-mode)
(set-face-foreground  'font-lock-string-face "SteelBlue")
(set-face-foreground  'font-lock-comment-face "LimeGreen")
(set-face-foreground  'font-lock-warning-face "Red")


; Setup C++ style to be physbam
(defconst c-mode-hook
  '(lambda ()
     (c-set-style "physbam")
     (run-hooks 'text-mode-hook)
    ; (auto-fill-mode t)
     (defconst fill-column 80)
     (setq truncate-lines nil)
     (column-number-mode 1)
     (line-number-mode 1)
;     (c-toggle-auto-state nil)
     (c-toggle-hungry-state 1)
;     (menu-add-menubar-index)
     ))

(defconst c++-mode-hook
  '(lambda ()
     (run-hooks 'c-mode-hook)))

(defconst asm-mode-set-comment-hook
  '(lambda ()
     (setq asm-comment-char ?\#)))

;#####################################################################
; extra binds
;#####################################################################
(global-set-key (kbd "M-o") 'physbam-header-flip)
(global-set-key (kbd "M-p") 'physbam-open-parent)
(global-set-key (kbd "<f2>") 'physbam-fix-copyright)
(global-set-key (kbd "C-<f2>") 'physbam-fix-copyright-user-list)
(global-set-key (kbd "<f3>") 'physbam-fix-function-comment)
(global-set-key (kbd "<f4>") 'next-error)
(global-set-key (kbd "<f5>") 'physbam-run)
(global-set-key (kbd "C-<f5>") 'physbam-run-debug)
(global-set-key (kbd "<f6>") 'physbam-run-viewer)
(global-set-key (kbd "<f7>") 'physbam-compile)
(global-set-key (kbd "<f1>") 'physbam-compile)
(global-set-key (kbd "C-<f7>") 'physbam-compile-current-file)
(global-set-key (kbd "M-[ d") 'backward-word)
(global-set-key (kbd "M-[ c") 'forward-word)
(global-set-key (kbd "M-<f12>") 'eval-current-buffer)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "<f8>") 'physbam-grep-public)
(global-set-key (kbd "<f11>") 'physbam-grep-public)
(global-set-key (kbd "<f9>") 'physbam-grep-projects)
(global-set-key (kbd "<f10>") 'physbam-grep-tools)
(global-set-key (kbd "C-<f8>") 'physbam-grep-replace-public)
(defun revert-buffer-no-prompt () (interactive) (revert-buffer nil t))
(global-set-key (kbd "M-r") 'revert-buffer-no-prompt)
(global-set-key (kbd "M-<f11>") 'physbam-fix-includes)
(global-set-key (kbd "C-<f11>") 'physbam-add-include)
(global-set-key (kbd "C-<f10>") 'physbam-find-class)
(global-set-key (kbd "C-c C-c") 'comment-dwim)
(global-set-key (kbd "C-<f12>") 'grep-cpp-and-headers)

; example
; (query-replace-regexp "\\(.+\\):" "\\1/\\1.csv" nil nil nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(default-input-method "rfc1345")
 '(display-buffer-reuse-frames t)
 '(fill-column 80)
 '(inhibit-startup-screen t)
 '(load-home-init-file t t)
 '(show-paren-mode t nil (paren))
 '(split-height-threshold 800)
 '(split-width-threshold 160)
 '(tool-bar-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "Black" :foreground "White" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

(put 'upcase-region 'disabled nil)

(put 'downcase-region 'disabled nil)
(setq use-file-dialog nil)

(defun jn-disable-<> ()
  (setq c-recognize-<>-arglists nil))
(add-hook 'c++-mode-hook 'jn-disable-<>)







(defun title-case-region-or-line (@begin @end)
  "Title case text between nearest brackets, or current line, or text selection.
Capitalize first letter of each word, except words like {to, of, the, a, in, or, and, …}. If a word already contains cap letters such as HTTP, URL, they are left as is.

When called in a elisp program, *begin *end are region boundaries.
URL `http://ergoemacs.org/emacs/elisp_title_case_text.html'
Version 2017-01-11"
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (let (
           $p1
           $p2
           ($skipChars "^\"<>(){}[]“”‘’‹›«»「」『』【】〖〗《》〈〉〔〕"))
       (progn
         (skip-chars-backward $skipChars (line-beginning-position))
         (setq $p1 (point))
         (skip-chars-forward $skipChars (line-end-position))
         (setq $p2 (point)))
       (list $p1 $p2))))
  (let* (
         ($strPairs [
                     [" A " " a "]
                     [" And " " and "]
                     [" At " " at "]
                     [" As " " as "]
                     [" By " " by "]
                     [" Be " " be "]
                     [" Into " " into "]
                     [" In " " in "]
                     [" Is " " is "]
                     [" It " " it "]
                     [" For " " for "]
                     [" Of " " of "]
                     [" Or " " or "]
                     [" On " " on "]
                     [" Via " " via "]
                     [" The " " the "]
                     [" That " " that "]
                     [" To " " to "]
                     [" Vs " " vs "]
                     [" With " " with "]
                     [" From " " from "]
                     ["'S " "'s "]
                     ["'T " "'t "]
                     ]))
    (save-excursion
      (save-restriction
        (narrow-to-region @begin @end)
        (upcase-initials-region (point-min) (point-max))
        (let ((case-fold-search nil))
          (mapc
           (lambda ($x)
             (goto-char (point-min))
             (while
                 (search-forward (aref $x 0) nil t)
               (replace-match (aref $x 1) "FIXEDCASE" "LITERAL")))
           $strPairs))))))

(setq dnd-protocol-alist '(("^file:" . dnd-insert-filename)))

(defun dnd-insert-filename (uri _action)
  (insert (dnd-get-local-file-name uri)))

(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
