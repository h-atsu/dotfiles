;; Basic settings
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(setq auto-save-default nil)

;; UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode t)

;; Font
(set-face-attribute 'default nil :height 140)

;; Indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; Package manager (use-package)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
