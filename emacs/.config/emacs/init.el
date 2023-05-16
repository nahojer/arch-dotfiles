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
             (define-key evil-motion-state-map (kbd "TAB") nil))

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
