#lang sicp

;; ordered set
(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((> (car set) x)
         (cons x set))
        ((= (car set) x)
         set)
        (else
         (cons (car set)
               (adjoin-set x (cdr set))))))

;; test
(adjoin-set 1 '())
(adjoin-set 4 (list 1 2 3 5))
(adjoin-set 5 (list 1 2 4))
(adjoin-set 2 (list 1 2 4))