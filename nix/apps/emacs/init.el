;; Basic settings
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(setq auto-save-default nil)

;; UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode t)
(set-face-attribute 'region nil :background "#3a3f5a" :foreground "#ffffff")

;; Font
(set-face-attribute 'default nil :family "JetBrains Mono" :height 140)
(set-fontset-font t 'latin "JetBrains Mono")
(set-fontset-font t 'japanese-jisx0208 "PlemolJP Console")

;; Indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; Key bindings
(keyboard-translate ?\C-h ?\C-?)

;; Package manager (use-package)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
