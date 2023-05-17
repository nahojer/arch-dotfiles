;;; Startup
;;; PACKAGE LIST
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("elpa" . "https://elpa.gnu.org/packages/")))

;;; BOOTSTRAP USE-PACKAGE
(package-initialize)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;;; Vim Bindings
(use-package evil
             :demand t
             :init
             ;; allows for using cgn
             ;; (setq evil-search-module 'evil-search)
             (setq evil-want-keybinding nil)
             :config
             (evil-mode 1)
             (evil-set-undo-system 'undo-redo)
             ;; Emacs in terminal cannot tell <tab> from TAB (which is the same as C-i).
             (define-key evil-motion-state-map (kbd "TAB") nil)
             ;; Scroll up like in vim.
             (define-key evil-motion-state-map (kbd "C-u") 'evil-scroll-up)
             (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
             (define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up))

;;; Vim Bindings Everywhere else
(use-package evil-collection
             :after evil
             :ensure t
             :config
             (evil-collection-init))

;;; Vertical completion UI based on the default completion system
(use-package vertico
             :init
             (vertico-mode))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
             :init
             (savehist-mode))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(custom-safe-themes
     '("15a4c95b442e6e7ef3b4e17f792f3c5b2a96e3f64589ae280dad648d97a64e5a" default)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  )
