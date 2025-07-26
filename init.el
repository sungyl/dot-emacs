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

;; Set up the GNU Emacs
(use-package emacs
  :config
  (common/set-font))

;; lab-theme - a color theme
;; https://github.com/MetroWind/lab-theme
(use-package lab-themes
  :ensure t
  :config (lab-themes-load-style 'light))

(provide 'init)

;;; init.el ends here
