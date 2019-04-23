#lang sicp
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))


(define (make-segment start end)
  (cons start end)
  )

(define (start-segment segment)
  (car segment)
  )

(define (end-segment segment)
  (cdr segment)
  )

(define (make-point x y)
  (cons x y)
  )

(define (x-point p)
  (car p)
  )

(define (y-point p)
  (cdr p)
  )


(define (average x y)
  (/ (+ x y) 2)
  )

(define (midpoint-segment segment)
  (let ((start (start-segment segment))
        (end (end-segment segment)))
    (make-point (average (x-point start) (x-point end))
                (average (y-point start) (y-point end))
                )
    )
  )

(print-point (make-segment (make-point 0 0) (make-point 1 1)))
(print-point (midpoint-segment (make-segment (make-point 0 0) (make-point 1 1)) ))