;;; ya-helm-posframe.el --- Yet another helm-posframe -*- lexical-binding: t -*-
;; Author: grugrut <grugruglut+github@gmail.com>
;; URL:
;; Version: 1.00
;; Package-Requires: ((emacs "26.0") (posframe "0.4.3") (helm "3.0"))

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:
(require 'cl-lib)
(require 'posframe)
(require 'helm)

(defgroup ya-helm-posframe nil
  "Using posframe to show helm."
  :group 'helm
  :prefix "ya-helm-posframe")

(defcustom ya-helm-posframe-font nil
  "The font used by ya-helm-posframe."
  :group 'ya-helm-posframe
  :type 'string)

(defcustom ya-helm-posframe-poshandler #'posframe-poshandler-frame-center
  "The poshandler of ya-helm-posframe."
  :group 'ya-helm-posframe
  :type 'function)

(defcustom ya-helm-posframe-parameters nil
  "The frame parameters used by ya-helm-posframe."
  :group 'ya-helm-posframe
  :type 'string)

(defface ya-helm-posframe '((t (:inherit default)))
  "Face used by the ya-helm-posframe."
  :group 'ya-helm-posframe)

(defvar ya-helm-posframe-buffer nil
  "The posframe-buffer used by ya-helm-posframe.")

(defvar helm-display-function--previous nil)

(defun ya-helm-posframe-display-function (buffer &optional _resume)
  "The display function which is used by `helm-display-function'.
Arugument BUFFER."
  (setq ya-helm-posframe-buffer buffer)
  (message "width %d, height %d" (+ (window-width) 2) helm-display-buffer-height)
  (posframe-show ya-helm-posframe-buffer
                 :font ya-helm-posframe-font
                 :position (point)
                 :poshandler ya-helm-posframe-poshandler
                 :background-color (face-attribute 'ya-helm-posframe :background nil t)
                 :foreground-color (face-attribute 'ya-helm-posframe :foreground nil t)
                 :width (+ (window-width) 2)
                 :height helm-display-buffer-height
                 :font ya-helm-posframe-font
                 :override-parameters ya-helm-posframe-parameters))

;;;###autoload
(define-minor-mode ya-helm-posframe-mode
  "Toggle helm posframe mode on of off."
  :group 'ya-helm-posframe
  :global t
  :lighter nil
  (if ya-helm-posframe-mode
      (progn
        (setq helm-display-function--previous helm-display-function
              helm-display-function 'ya-helm-posframe-display-function))
    (posframe-hide ya-helm-posframe-buffer)
    (setq helm-display-function helm-display-function--previous
          helm-display-function-pprevious nil)))

(provide 'ya-helm-posframe)

;;; ya-helm-posframe.el ends here
