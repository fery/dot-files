(add-to-list 'package-archives
             '("MyMelpa" . "~/repository/melpa/packages/") t)
(package-initialize)

(setq prelude-packages
      (append prelude-packages
              '(csv-mode smex switch-window ace-jump-mode yaml-mode zencoding-mode)))

(unless (prelude-packages-installed-p)
  ;; check for new packages (package versions)
  (message "%s" "Emacs Prelude is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p prelude-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;; set default directory to $HOME
(setq default-directory "~/")

;; use solarized dark theme
(load-theme 'solarized-dark t)

;; make sure path is correct when launched as application
(setenv "PATH" (concat "/usr/local/share/python:/usr/local/bin:/usr/local/sbin:" (getenv "PATH")))
(push "/usr/local/bin" exec-path)
(push "/usr/local/sbin" exec-path)
(push "/usr/bin" exec-path)
(push "/bin" exec-path)

(server-start)

(require 'textmate)
(require 'peepopen)

(setq ns-pop-up-frames nil)

(textmate-mode)

;; mac friendly font
;; Menlo-12
(set-face-attribute 'default nil :font "Cousine-12")

;; ace-jump for easy navigation in the current buffer
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(setq ido-use-filename-at-point t)
(setq ido-enable-flex-matching t)
(ido-mode t)
(ido-everywhere t)
(add-hook 'ido-setup-hook 'custom-ido-extra-keys)
(defun custom-ido-extra-keys ()
  "Add my keybindings for ido."
  (define-key ido-completion-map "\C-n" 'ido-next-match)
  (define-key ido-completion-map "\C-p" 'ido-prev-match)
  (define-key ido-completion-map " "    'ido-exit-minibuffer))

(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point nil
      ido-max-prospects 10
      ido-save-directory-list-file "~/.emacs.d/emacs-meta/.ido.last")

;; Move to trash when deleting stuff
(setq delete-by-moving-to-trash t
      trash-directory "~/.Trash/emacs")

;; Ignore .DS_Store files with ido mode
(add-to-list 'ido-ignore-files "\\.DS_Store")


;; disable startup and scratch message
(setq inhibit-startup-message 't)
(setq initial-scratch-message nil)


;; delete trailing whitespaces before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; load yas snippets
(require 'yasnippet)
(yas/load-directory "~/.emacs.d/personal/snippets")


(scroll-bar-mode -1)
