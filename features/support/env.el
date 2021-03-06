(require 'ert)
(require 'cl-lib)
(require 'espuds)
(require 'f)

(let* ((support-path (f-dirname load-file-name))
       (root-path (f-parent (f-parent support-path))))
  (add-to-list 'load-path (concat root-path "/lisp"))
  (add-to-list 'load-path (concat root-path "/tests")))

(require 'nnreddit-test)

(defmacro if-demote (demote &rest forms)
  (declare (debug t) (indent 1))
  `(if ,demote
       (with-demoted-errors "demoted: %s"
         ,@forms)
     ,@forms))

(defun cleanup ()
  (let* ((newsrc-file gnus-current-startup-file)
         (quick-file (concat newsrc-file ".eld")))
    (when (file-exists-p quick-file)
      (message "Deleting %s" quick-file)
      (delete-file quick-file))))

(Setup
 )

(After
 )

(Teardown
 (cleanup)
)

(Fail
 (if noninteractive
     (with-demoted-errors "demote: %s"
       (Then "end recordings")
       (Teardown))
   (backtrace)
   (keyboard-quit))) ;; useful to prevent emacs from quitting
