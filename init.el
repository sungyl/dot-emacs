;;; init.el --- The Emacs Initialization File -*- lexical-binding: t -*-

;; Copyright (C) 2025  Dmitry Jakovlev

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;    My personal configuration for GNU Emacs.

;;; Code:

(require 'package)
(require 'use-package)

;; Set up package.el
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/")) ; MELPA

(package-initialize)

;; Set a path to a custom file
(setq custom-file (concat user-emacs-directory "custom.el"))

(when (file-exists-p custom-file)
  (load custom-file))

;; Set a font
(defvar common/font
  (cond ((eq system-type 'darwin)     '(:family "Monaco" :height 140))
	((eq system-type 'windows-nt) '(:family "Consolas" :height 140))
	(t                            '(:family "JetBrains Mono" :height 140)))
  "Default font")

(defun common/set-font ()
  "A function to set a font for current OS."
  (apply 'set-face-attribute 'default nil common/font)
  (if (eq system-type 'windows-nt)
      (setq w32-use-visible-system-caret nil)))

;; Set up UI
(defun common/ui ()
  "A function to set up UI."
  ;; cursor is a box
  (setq-default cursor-type 'box)
  ;; maximize a window on startup
  (add-hook 'window-setup-hook 'toggle-frame-maximized)
  ;; doesn't show an initial logo
  (setq inhibit-splash-screen t))

(defun common/text ()
  "A function to set up text."
  ;; Use UTF-8 everywhere
  (set-language-environment 'UTF-8)
  (setq default-buffer-file-coding-system 'utf-8-unix)
  ;; Use spaces instead of tabs
  (setq-default indent-tabs-mode nil)
  ;; Default tab width
  (setq-default tab-width 4)
  ;; A function to indent the current line
  (setq indent-line-function 'indent-relative)
  ;; List of tab stop positions
  (setq tab-stop-list (number-sequence 4 200 4))
  ;; Use TAB for completion
  (setq tab-always-indent 'complete))

;; Set up the GNU Emacs
(use-package emacs
  :config
  (common/set-font)
  (common/ui)
  (common/text))

;; lab-theme - a color theme
;; https://github.com/MetroWind/lab-theme
(use-package lab-themes
  :ensure t
  :config (lab-themes-load-style 'light))

(provide 'init)

;;; init.el ends here
