#lang sicp

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (unit-set set1 set2)
  (cond ((null? set2) set1)
        ((null? set1) set2)
        ((element-of-set? (car set2) set1)
         (unit-set set1 (cdr set2)))
        (else (cons (car set2)
                    (unit-set set1 (cdr set2))))))

;; test
(intersection-set (list 1 2 3 4) (list 1 2 3))
(unit-set (list 2 4 6 8) (list 1 3 5 7 8))
(unit-set '() (list 1 3 5 7 8))
(unit-set (list 2 4 6 8) '())