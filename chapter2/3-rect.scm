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

(define (rect origin width height)
  (cons origin (cons width height))
  )

(define r (rect (make-point 0 1) 1 1))


(define (perimeter rect)
  (* (+ (car (cdr rect))
        (cdr (cdr rect)))
   2)
  )

(define (area rect)
  (* (car (cdr rect))
        (cdr (cdr rect)))
  )

(perimeter r)
(area r)

