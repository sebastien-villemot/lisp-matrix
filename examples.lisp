(in-package :cl-user)

;; (asdf:oos 'asdf:compile-op 'lisp-matrix :force t)
;; (asdf:oos 'asdf:load-op 'lisp-matrix)
(defpackage :lisp-matrix-user-ex
  (:use :cl
	:lisp-matrix))

(in-package :lisp-matrix-user-ex)


(progn ;; THESE WORK!
  
  ;; make some matrices

  (defvar m1 nil
    "placeholder 1")
  (setf m1 (make-matrix 2 5
			:implementation :lisp-array  ;; :foreign-array
			:element-type 'double-float))
  

  ;; works, as it should.
  (mref m1 1 3)
  (setf (mref m1 1 3) 1.2d0)
  m1


  ;; increase complexity

  (defvar m2 nil
    "placeholder 2")
  (setf m2 (make-matrix 2 5
			:implementation :lisp-array  ;; :foreign-array
			:element-type 'integer ; 'double-float
			;; :initial-contents (list 1 2 3 4 5 6 7 8 9 10)
			:initial-contents #2A(( 1 2 3 4 5)
					      ( 6 7 8 9 10))))




  (mref m2 0 2) ;; -> 3
  m2
  (transpose m2)

  (defvar m3 nil
    "placeholder 3")

  (setf m3 (make-matrix 6 5 :initial-contents '((1d0 2d0 3d0 4d0 5d0)
                                                 (6d0  7d0  8d0  9d0  10d0)
                                                 (11d0 12d0 13d0 14d0 15d0)
                                                 (16d0 17d0 18d0 19d0 20d0)
                                                 (21d0 22d0 23d0 24d0 25d0)
                                                 (26d0 27d0 28d0 29d0 30d0))))
  (row m3 2)
  (col m3 1)


  (mref m3 0 1)
  (mref (transpose m3) 1 0)

  (mref m3 2 2)
  (mref (transpose m3) 2 2)

  m3
  (transpose m3)


  (defvar m4 nil
    "yet another placeholder.")
  (setf m4 (strides m3 :nrows 2 :row-stride 2))
  m4
  (m= (row m4 0)
      (make-matrix 1 5 :initial-contents '((1d0 2d0 3d0 4d0 5d0))))
  (m= (row m4 1)
      (make-matrix 1 5 :initial-contents '((11d0 12d0 13d0 14d0 15d0))))
  ;; note the redoing for the columns -- different!
  (m= (col m4 0)
      (make-matrix 2 1 :initial-contents '((1d0) (11d0))))
  (m= (col m4 1)
      (make-matrix 2 1 :initial-contents '((2d0) (12d0))))

  (v= (row m4 0) (col (transpose m4) 0))
  (v= (col m4 0) (row (transpose m4) 0))

  )



(progn ;; FIX ALL THE ERRORS

  ;; FIXME: need to get the foriegn-friendly arrays package involved. 
  (defvar m2a nil
    "placeholder 2")
  (setf m2a (make-matrix 2 5
			:implementation :foreign-array ;; :lisp-array
			:element-type 'integer ; 'double-float
			;; :initial-contents (list 1 2 3 4 5 6 7 8 9 10)
			:initial-contents #2A(( 1 2 3 4 5)
					      ( 6 7 8 9 10))))

  ;; FIXME -- bad error!!
  ;; This index isn't correct, and it doesn't barf correctly. 
  (mref m1 2 3)
  (setf (mref m1 2 3) 1.2d0)
  m1

  ;; FIXME: the following has no applicable method!
  (m* m2 (transpose m2))


  m4
  (transpose m4)
  ;; given the above...
  ;; FIXME: Big Barf!
  (v= (row m4 1) (col (transpose m4) 1)) ;; fails ???

  ;; and the same problem.
  m3 
  (transpose m3)
  (v= (col m3 1) (row (transpose m3) 1))
  (v= (row m3 1) (col (transpose m3) 1))

  )




;; manipulate

;; operate 

;; do some blas/lapack

;; output
