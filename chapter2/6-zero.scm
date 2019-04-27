#lang sicp

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(add-1 zero)

(add-1 (lambda (x) x))

(lambda (f) (lambda (x) (f (((lambda (x) x) f) x))))
(lambda (f) (lambda (x) (f (f x))))

(lambda (x) (f (f (f x))))