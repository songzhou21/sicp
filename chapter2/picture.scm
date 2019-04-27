#lang sicp

;;; Vector
(define (make-vect xcor ycor)
  (list xcor ycor)
  )

(define (xcor-vect v)
  (car v)
  )

(define (ycor-vect v)
  (cadr v)
  )

(define (add-vect a b)
  (make-vect (+ (xcor-vect a) (xcor-vect b))
             (+ (ycor-vect a) (ycor-vect b))
             )
  )

(define (sub-vect a b)
  (make-vect (- (xcor-vect a) (xcor-vect b))
             (- (ycor-vect a) (ycor-vect b))
             )
  )

(define (scale-vect vect s)
  (make-vect (* s (xcor-vect vect)) (* s (xcor-vect vect)))
  )

;;; Frame
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

;;; Segment
(define (make-segment start end)
  (list start end))

(define (start-segment segment)
  (car segment)
  )

(define (end-segment segment)
  (cadr segment)
  )



;;; EXERCISES

;; EXERCISE 2.48
#|
(define seg (make-segment (make-vect 0.0 0.0)
                          (make-vect 1.0 1.0)))
(display seg)
(newline)
(start-segment seg)
(end-segment seg)
|#


