(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("b181ea0cc32303da7f9227361bb051bbb6c3105bb4f386ca22a06db319b08882" "2b8dff32b9018d88e24044eb60d8f3829bd6bbeab754e70799b78593af1c3aba" "962dacd99e5a99801ca7257f25be7be0cebc333ad07be97efd6ff59755e6148f" default)))
 '(package-selected-packages
   (quote
    (flycheck evil-leader exec-path-from-shell json-mode neotree helm-projectile helm-swoop helm org-bullets key-chord go-mode airline-themes markdown-mode use-package evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'load-path "~/.emacs.d/custom")

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package markdown-mode
  :ensure t)

(setq evil-want-C-u-scroll t)
(require 'evil-leader)
(global-evil-leader-mode)
(require 'evil)
(evil-mode t)
(evil-leader/set-leader ",")

(require 'powerline)
(require 'powerline-evil)
(powerline-evil-vim-color-theme)

(load-theme 'solarized-dark t)

(toggle-frame-fullscreen)
;(setq mac-command-modifier 'meta)
;(setq mac-right-command-modifier 'left)
(global-linum-mode)
(scroll-bar-mode -1)
(require 'airline-themes)
(load-theme 'airline-solarized-gui)
(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(set-face-attribute 'default t :family "Inconsolata" :height 120)
(require 'linum-off)
(with-eval-after-load 'org (setq org-startup-indented t))
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-agenda-files (list "~/org/"))
(setq org-todo-keywords
       '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(require 'neotree)
(defun neotree-project-dir ()
    "Open NeoTree using the git root."
    (interactive)
    (let ((project-dir (projectile-project-root))
          (file-name (buffer-file-name)))
      (neotree-toggle)
      (if project-dir
          (if (neo-global--window-exists-p)
              (progn
                (neotree-dir project-dir)
                (neotree-find file-name)))
        (message "Could not find git project root."))))
(global-set-key [f8] 'neotree-project-dir)

(use-package json-mode
  :ensure t)
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))
(when window-system (set-exec-path-from-shell-PATH))
(setenv "GOPATH" "~/Developer/Go")
(add-to-list 'exec-path "~/Developer/Go/bin")
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "/usr/bin")
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)
(evil-leader/set-key-for-mode 'go-mode "," 'godef-jump)
(evil-leader/set-key-for-mode 'go-mode "o" 'godef-jump-other-window)
(evil-leader/set-key-for-mode 'go-mode "." 'pop-tag-mark)
(evil-leader/set-key-for-mode 'go-mode "d" 'godef-describe)
(evil-leader/set-key-for-mode 'go-mode "?" 'godoc-at-point)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
