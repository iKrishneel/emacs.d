
; start package.el with emacs
(require 'package)
; add MELPA to repository list
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
; initialize package.el
(package-initialize)


; start auto-complete with emacs
(require 'auto-complete)

; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)


;; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)


;; turn on auto-indent
(add-hook 'c-mode-common-hook '(lambda ()
      (local-set-key (kbd "RET") 'newline-and-indent)))

;; iedit
(require 'iedit)
(define-key global-map (kbd "C-c ;") 'iedit-mode)


; turn on Semantic
(semantic-mode 1)
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

;;enable global support for Semanticdb
(global-semanticdb-minor-mode 1)
;(global-semantic-highlight-func-mode 1)
(global-semanticdb-minor-mode 1)


;; turn on auto-indent
(setq c-default-style "ellemtel"
          c-basic-offset 5)


; turn on ede mode 
(global-ede-mode 1)
(global-semantic-idle-scheduler-mode 1)



;; turn on copyright
;(add-hook 'before-save-hook 'copyright-update) 

;;Create hook to progrma header files
;;(ede-cpp-root-project "program" :file "~/Desktop/Program/boundary_detection/main.cpp"
;;		            :include-path '("/headers"))


;; turn on autopairing of backets
(require 'autopair)
  (autopair-global-mode) ;; to enable in all buffers


;; turn on highlight paren mode
(show-paren-mode 1)


;; turn on number line
(global-linum-mode t)
(setq linum-format "%d  ")


;; Show the cursor line
(require 'hlinum)
(hlinum-activate)


(require 'auto-complete-clang)
(require 'auto-complete-clang-async)


; turn on Point Cloud Library
(load-file "~/.emacs.d/pcl-c-style.el")
(add-hook 'c-mode-common-hook 'pcl-set-c-style)


;; key for opening header file
(global-set-key (kbd "C-x C-o") 'ff-find-other-file)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set Up color 
;Language support
(setq auto-mode-alist
      (append
    '(("\\.F$"    . fortran-mode)
      ("\\.inc$"  . fortran-mode)
      ("\\.C$"    . c++-mode)
      ("\\.cc$"   . c++-mode)
      ("\\.h$"    . c++-mode)
      ("\\.cxx$"  . c++-mode)
      ("\\.html$" . html-mode)
        ) 
    auto-mode-alist))

; Set up C++ variables
;
(setq c-recognize-knr-p nil)
(add-hook 'c++-mode-hook (function (lambda () (c-set-style "Ellemtel"))))
(add-hook 'c++-mode-hook 'font-lock-mode )


;;Auto indent
(set (make-local-variable 'aai-indent-function)
     'aai-indent-defun)

;; start flymake-google-cpplint-load
(require 'flymake-google-cpplint)
(add-hook 'c++-mode-hook 'flymake-google-cpplint-load)


;; start google-c-style with emacs
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

; ------------------------------------------------------------
; Color coding
(setq gc-cons-threshold 1000000)

;(require 'vc-status)

(if (eq window-system 'x)
    (progn
      (transient-mark-mode t)
      
      (if (fboundp 'what\ line) (fmakunbound 'what\ line))
      (if (fboundp 'set\ cursor\ free) (fmakunbound 'set\ cursor\ free))
      (if (fboundp 'set\ cursor\ bound)
          (fmakunbound 'set\ cursor\ bound))
      (if (fboundp 'set\ scroll\ margins)
          (fmakunbound 'set\ scroll\ margins))
      (if (fboundp 'what\ line) (fmakunbound 'what\ line))
      
      (if (x-display-color-p)
          (progn
            (eval-after-load
             "font-lock"
             '(progn
                (setq c-font-lock-keywords    c-font-lock-keywords-2
                      c++-font-lock-keywords  c++-font-lock-keywords-2
                      lisp-font-lock-keywords lisp-font-lock-keywords-2)))

            (global-font-lock-mode t)
            
            (mapcar (function
                     (lambda (flist)
                       (copy-face (car (cdr flist)) (car flist))
                       (set-face-foreground (car flist) (car (cdr (cdr flist))))
))
                          
                    '((italic-blue              italic          "deepskyblue")
                      (italic-turquiose         italic          "turquoise")
                      (italic-orange            italic          "orange")
                      (bold-yellow              bold            "yellow")
                      (bold-green               bold            "green")
                      (default-red              default         "red")))
            
            (setq font-lock-comment-face       'italic-blue
                  font-lock-doc-string-face    'italic-turquiose
                  font-lock-string-face        'italic-orange
                  font-lock-function-name-face 'bold-yellow
                  font-lock-keyword-face       'bold-green
                  font-lock-type-face          'default-red)
            
    
;            (set-face-foreground 'font-lock-comment-face "saddle brown")
;            (set-face-foreground 'font-lock-doc-string-face "chocolate")
;            (set-face-foreground 'font-lock-string-face "firebrick")
;            (set-face-foreground 'font-lock-function-name-face "blue")
;            (set-face-foreground 'font-lock-keyword-face "slate blue")
;            (set-face-foreground 'font-lock-type-face "steel blue")
            (set-face-background 'region "yellow")
            (set-face-foreground 'region "hot pink")
	    
            (setq w3-node-style 'font-lock-keyword-face)
            (setq w3-address-style 'font-lock-comment-face)
            (setq w3-bold-style 'font-lock-keyword-face)
            (setq w3-italic-style 'font-lock-comment-face)
            )
                                        ; else x-display-color-p
        (if (eq 'gray-scale (x-display-visual-class))
            (progn
              (set-face-background 'region "DarkSlateGrey")
              )
          (progn
            (set-face-background 'region "White")
            (set-face-foreground 'region "Black")
            (setq hilit-background-mode 'mono)
            )
          )
        )
      )
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;; Latex
(setq latex-run-command "pdflatex")
(set-default 'preview-scale-function 1.2)

 (require 'tex)
(TeX-global-PDF-mode t)


(require 'ede)
;(require 'cedet)

;(require 'semantic-c)
(setq semantic-load-turn-useful-things-on t)

(semantic-add-system-include "/usr/include/" 'c-mode)
(semantic-add-system-include "/usr/include/" 'c++-mode)





;; C++ Mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(require 'cl)

(defun file-in-directory-list-p (file dirlist)
  "Returns true if the file specified is contained within one of
the directories in the list. The directories must also exist."
  (let ((dirs (mapcar 'expand-file-name dirlist))
        (filedir (expand-file-name (file-name-directory file))))
    (and
     (file-directory-p filedir)
     (member-if (lambda (x) ; Check directory prefix matches
                  (string-match (substring x 0 (min(length filedir) (length x))) filedir))
                dirs))))

(defun buffer-standard-include-p ()
  "Returns true if the current buffer is contained within one of
the directories in the INCLUDE environment variable."
  (and (getenv "INCLUDE")
       (file-in-directory-list-p buffer-file-name (split-string (getenv "INCLUDE") path-separator))))

(add-to-list 'magic-fallback-mode-alist '(buffer-standard-include-p . c++-mode))


; style I want to use in c++ mode
(c-add-style "my-style" 
	     '("stroustrup"
	       (indent-tabs-mode . nil)        ; use spaces rather than tabs
	       (c-basic-offset . 4)            ; indent by four spaces
	       (c-offsets-alist . ((inline-open . 0)  ; custom indentation rules
				   (brace-list-open . 0)
				   (statement-case-open . +)))))

(defun my-c++-mode-hook ()
  (c-set-style "my-style")        ; use my-style defined above
  (auto-fill-mode)         
  (c-toggle-auto-hungry-state 1))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)

(define-key c++-mode-map "\C-ct" 'some-function-i-want-to-call)
(put 'upcase-region 'disabled nil)



; roslaunch highlighting
(add-to-list 'auto-mode-alist '("\\.launch$" . xml-mode))



;(require 'yaml-mode)
;    (add-to-list 'auto-mode-alist '("\\yaml$" . yaml-mode))

;(add-hook 'yaml-mode-hook
;      '(lambda ()
;        (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
; Add cmake listfile names to the mode list.
(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))

(autoload 'cmake-mode "/usr/share/emacs/site-lisp/cmake-mode.el" t)



;; color the entire line
(global-hl-line-mode 1) 
;; To customize the background color
(set-face-background 'hl-line "green")
;; -- color of line
(set-face-background 'hl-line "pink")


;; python auto-complete
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (pylint elpy ac-math ecb ## color-theme solarized-theme latex-preview-pane auctex-latexmk yatemplate yaml-mode jedi iedit hlinum google-c-style git flymake-google-cpplint flymake-cursor flymake-cppcheck el-autoyas autopair auto-yasnippet auto-complete-nxml auto-complete-exuberant-ctags auto-complete-clang-async auto-complete-clang auto-complete-chunk auto-complete-c-headers auto-auto-indent ac-c-headers))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



; Turn on auto-insert
(eval-after-load 'autoinsert
  '(define-auto-insert '("\\.c\\'" . "C skeleton")
     '(
       "Short description: "
       "/**\n * "
       (file-name-nondirectory (buffer-file-name))
       " -- " str \n
       " *" \n
       " * Written on " (format-time-string "%A, %e %B %Y.") \n
       " */" > \n \n
       "#include <stdio.h>" \n
       "#include \""
       (file-name-sans-extension
        (file-name-nondirectory (buffer-file-name)))
       ".h\"" \n \n
       "int main(int argc, const char* argv[]) {" \n
       "return 0;" >
       > _ \n
       "}" > \n)))



;; turn on lisp autocomplete
(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)



;; turn on offscreen bracket highlight
(defadvice show-paren-function
      (after show-matching-paren-offscreen activate)
      (interactive)
      (let* ((cb (char-before (point)))
             (matching-text (and cb
                                 (char-equal (char-syntax cb) ?\) )
                                 (blink-matching-open))))
        (when matching-text (message matching-text))))


;; latex
(require 'auctex-latexmk)
(auctex-latexmk-setup)

(latex-preview-pane-enable)


(if window-system (require 'font-latex))
(setq font-lock-maximum-decoration t)


;; color theme
 (require 'color-theme)
(color-theme-initialize)
;;(color-theme-shaman)

;; Change color of C/C++ comment
(set-face-foreground 'font-lock-string-face "green")
(set-face-foreground 'font-lock-comment-face "red")



;; latex ac-maths
(require 'ac-math)
(add-to-list 'ac-modes 'latex-mode)
(defun ac-latex-mode-setup ()  
  (setq ac-sources
     (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
               ac-sources)))
(add-hook 'TeX-mode-hook 'ac-latex-mode-setup)


;; ace popup
(ace-popup-menu-mode 1)
