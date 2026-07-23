;; mjr-apply-with-dired-magic --- magic dired apply. -*-coding: utf-8 lexical-binding:t; mode:emacs-lisp; fill-column:158 -*-

;; Copyright (c) 2026-2026 Mitch Richling <https://www.mitchr.me>.  All rights reserved.
;;
;; Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
;;
;; 1. Redistributions of source code must retain the above copyright notice, this list of conditions, and the following disclaimer.
;;
;; 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions, and the following disclaimer in the documentation
;;    and/or other materials provided with the distribution.
;;
;; 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without
;;    specific prior written permission.
;;
;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
;; FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
;; SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
;; TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

;; Author:      Mitch Richling
;; Version:     0.1
;; Keywords:    mjr-apply-with-dired-magic
;; URL:         https://github.com/richmit/mjr-apply-with-dired-magic

;; This file is not part of Emacs

;;; Install:
;; See the README: https://github.com/richmit/mjr-apply-with-dired-magic/

;;; Commentary:
;; See the README: https://github.com/richmit/mjr-apply-with-dired-magic/

;;; Code:

(require 'dired)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defun mjr-apply-with-dired-magic (func &rest func-args)
  "In a non-dired buffer, execute FUNC.  In dired, do find-file-noselect on each marked file and execute FUNC in each buffer.
Note that find-file will reuse an existing buffer already visiting a file instead of loading it again.  
Also note that find-file verifies that the file has not changed since visited or saved."
  (if (not (equal major-mode 'dired-mode))
      (apply func func-args)
      (let ((marked-files (dired-get-marked-files)))
        (unless marked-files
          (error "mjr-apply-with-dired-magic: ERROR: No marked files!!"))
        (mapc (lambda (file-name)
                (message "mjr-apply-with-dired-magic: Applying %s to file: %s" func file-name)
                (with-current-buffer (find-file-noselect file-name)
                  (apply func func-args)))
              marked-files)
        (message "mjr-apply-with-dired-magic: File processing complete!!"))))

(provide 'mjr-apply-with-dired-magic)

;;; filename ends here
