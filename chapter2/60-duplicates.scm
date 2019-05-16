#lang sicp

;; O(n)
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

;; O(1)
(define adjoin-set cons)

;; O(n^2)
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

;; O(n)
(define unit-set append)

;;

#|
in applications where we're going to use adjoin-set much more frequently than any of the other operations
 (and where memory is not a concern) it may be preferable to use the implementation that allows duplicates.
|#

; test
(define set-data (list 2 3 2 1 3 2 2)) ; {1,2,3}
(element-of-set? 1 set-data)
(adjoin-set 1 set-data)
(adjoin-set 4 set-data)
(intersection-set set-data (list 1 2 3 4))
(unit-set set-data (list 1 3 5 7 8))