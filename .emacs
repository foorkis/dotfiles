(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
;; (setq column-number-mode t)
;; (setq line-number-mode t)
(setq inhibit-startup-screen t)

(fset 'yes-or-no-p 'y-or-n-p)

(blink-cursor-mode 0)
(setq mouse-yank-at-point t)

;frame navigation with M-arrow
(windmove-default-keybindings 'meta)

;;C-c arrow to restore prev-next layout
(winner-mode t)

;;magit status
;;(global-set-key (kbd "C-x g") ’magit-status)

;; Load customize settings
(setq custom-file "~/.emacs.d/custom-file.el")
(load custom-file)

; resize with mod-M-arrow
(defun win-resize-top-or-bot ()
  "Figure out if the current window is on top, bottom or in the middle"
  (let* ((win-edges (window-edges))
         (this-window-y-min (nth 1 win-edges))
         (this-window-y-max (nth 3 win-edges))
         (fr-height (frame-height)))
    (cond ((eq 0 this-window-y-min) "top")
          ((eq (- fr-height 1) this-window-y-max) "bot") (t "mid"))))
(defun win-resize-left-or-right ()
  "Figure out if the current window is to the left, right or in the middle"
  (let* ((win-edges (window-edges))
         (this-window-x-min (nth 0 win-edges))
         (this-window-x-max (nth 2 win-edges))
         (fr-width (frame-width)))
    (cond ((eq 0 this-window-x-min) "left")
          ((eq (+ fr-width 4) this-window-x-max) "right") (t "mid"))))
(defun win-resize-enlarge-horiz ()
  (interactive)
  (cond ((equal "top" (win-resize-top-or-bot)) (enlarge-window -1))
        ((equal "bot" (win-resize-top-or-bot)) (enlarge-window 1))
        ((equal "mid" (win-resize-top-or-bot)) (enlarge-window -1))
        (t (message "nil"))))
(defun win-resize-minimize-horiz ()
  (interactive)
  (cond ((equal "top" (win-resize-top-or-bot))
         (enlarge-window 1))
        ((equal "bot" (win-resize-top-or-bot)) (enlarge-window -1))
        ((equal "mid" (win-resize-top-or-bot)) (enlarge-window 1))
        (t (message "nil"))))
(defun win-resize-enlarge-vert ()
  (interactive)

(windmove-default-keybindings 'meta)
  (cond ((equal "left" (win-resize-left-or-right))
         (enlarge-window-horizontally -1))
        ((equal "right" (win-resize-left-or-right))
         (enlarge-window-horizontally 1))
        ((equal "mid" (win-resize-left-or-right))
         (enlarge-window-horizontally -1))))
(defun win-resize-minimize-vert ()
  (interactive)
  (cond ((equal "left" (win-resize-left-or-right))
         (enlarge-window-horizontally 1))
        ((equal "right" (win-resize-left-or-right))
         (enlarge-window-horizontally -1))
        ((equal "mid" (win-resize-left-or-right))
         (enlarge-window-horizontally 1))))
(global-set-key [s-M-right] 'win-resize-minimize-vert)
(global-set-key [s-M-left] 'win-resize-enlarge-vert)
(global-set-key [s-M-down] 'win-resize-minimize-horiz)
(global-set-key [s-M-up] 'win-resize-enlarge-horiz)

;idk wheter i need that
(setq european-calendar-style 't)
(setq calendar-week-start-day 1)

;c++ indent style
(setq c-default-style "linux" c-basic-offset 4)
;no tabs
(setq-default indent-tabs-mode nil)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; (load-theme 'tao-yin)
(load-theme 'tango-dark t)

(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))
(require 'cl)

;; (set-face-attribute 'default nil :font "Terminus 13")     ;;13
;; (set-fontset-font t 'unicode "Terminus 13" nil 'prepend)  ;;13

;;via orgmode tutorial
;;https://habrahabr.ru/post/105300/
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;;md mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;ace-window
;;(global-set-key (kbd "M-p") 'ace-window)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;  (require 'org-latex)
;; ;; (require 'org)
;; ;; ;; List of additional LaTeX packages
;; (add-to-list 'org-export-latex-packages-alist '("" "cmap" t))
;; (add-to-list 'org-export-latex-packages-alist '("english,russian" "babel" t))
;; (require 'org-mode)

(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))
;;(transparency 80)

;;(add-hook 'erc-mode-hook 'erc-scrollbottom-enable)
;;(add-to-list 'erc-mode-hook (lambda ()
;;(set (make-local-variable 'scroll-conservatively) 100)))

(require 'tls)
(require 'ox-odt)

;; org-agenda
(setq org-agenda-files (list "~/org/work.org"
                             "~/org/todo.org"))

;;haskell simple indentation
(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;;cpp-hpp jumps
(global-set-key (kbd "C-c C-f") 'ff-find-other-file)

;; ;;multiple cursors
;; (require 'multiple-cursors)
;; (global-set-key (kbd "C->")  'mc/mark-next-like-this)
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(custom-safe-themes
;;    (quote
;;     ("a2e7b508533d46b701ad3b055e7c708323fb110b6676a8be458a758dd8f24e27" "63dd8ce36f352b92dbf4f80e912ac68216c1d7cf6ae98195e287fd7c7f7cb189" "fe243221e262fe5144e89bb5025e7848cd9fb857ff5b2d8447d115e58fede8f7" default)))
;;  '(package-selected-packages
;;    (quote
;;     (multiple-cursors geiser neotree tao-theme flatland-theme sprunge slime php-mode ox-twbs ox-html5slide ox-gfm magit lua-mode haskell-mode evil))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )
(put 'narrow-to-region 'disabled nil)
