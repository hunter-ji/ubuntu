(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'real-auto-save)
(add-hook 'prog-mode-hook 'real-auto-save-mode)

(setq real-auto-save-interval 5) ;; in seconds
