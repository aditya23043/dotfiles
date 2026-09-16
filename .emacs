(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)

(global-display-line-numbers-mode 1)
(column-number-mode 1)

(setq ring-bell-function #'ignore)

(global-hl-line-mode 1)

(set-face-attribute 'default nil
                    :height 150)

;; THEME RULE

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7"
     default))
 '(package-selected-packages
   '(cape consult corfu eldoc-box evil-collection gnu-elpa-keyring-update
	  gruber-darker-theme marginalia orderless vertico websocket
	  yasnippet)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'gruber-darker t)

;; PACKAGE CONFIG

(require 'package)

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("nongnu". "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)

;; VIM BINDINGS

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Which key

(use-package which-key
  :config
  (which-key-mode))

;; Completion

(use-package vertico
  :init
  (vertico-mode))
(use-package orderless
  :custom
  (completion-styles '(orderless basic)))
(use-package marginalia
  :init
  (marginalia-mode))
(use-package consult)

;; In-buffer code completion (corfu = popup UI, cape = extra sources)

(use-package corfu
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode)   ; add this line
  :custom
  (corfu-auto t)          ; show popup automatically as you type
  (corfu-auto-delay 0.05)
  (corfu-auto-prefix 1)
  (corfu-cycle t))        ; wrap around at the end of the list

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

;; LSP client (built into Emacs 30 — no package install needed)

(use-package eglot
  :hook
  (c-mode . eglot-ensure)
  (c++-mode . eglot-ensure))

(use-package yasnippet
  :init
  (yas-global-mode 1))

(with-eval-after-load 'yasnippet
  (define-key yas-keymap (kbd "C-j") #'yas-next-field)
  (define-key yas-keymap (kbd "C-k") #'yas-prev-field))

(use-package eldoc-box
  :hook (eglot-managed-mode . eldoc-box-hover-mode))
