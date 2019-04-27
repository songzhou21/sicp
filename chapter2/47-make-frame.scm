(load "46-vect.scm")

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))


(define (origin-frame frame)
  (car frame)
  )

(define (edge1-frame frame)
  (car (cdr frame))
  )

(define (edge2-frame frame)
  (car (cdr (cdr frame)))
  )

(define f1 (make-frame (make-vect 0.0 0.0)
                          (make-vect 0.3 0.3)
                          (make-vect 0.6 0.6)))

(origin-frame f1)
(edge1-frame f1)
(edge2-frame f1)



(define (make-frame2 origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame2 frame)
  (car frame)
  )

(define (edge1-frame2 frame)
  (car (cdr frame))
  )

(define (edge2-frame2 frame)
  (cdr (cdr frame))
  )

(define f2 (make-frame2 (make-vect 0.0 0.0)
                          (make-vect 0.3 0.3)
                          (make-vect 0.6 0.6)))

(origin-frame2 f2)
(edge1-frame2 f2)
(edge2-frame2 f2)
