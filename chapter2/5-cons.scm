#lang sicp

(define (cons x y)
  (* (expt 2 x)
     (expt 3 y)
  ))

(cons 3 2)

(define (car z)
  (if (= (remainder z 2) 0)
      (+ (car (/ z 2)) 1)
      0
      )
  )


(define (cdr z)
  (if (= (remainder z 3) 0)
      (+ (cdr (/ z 3)) 1)
      0
      )
  )


(car (cons 3 2))
(cdr (cons 3 2))