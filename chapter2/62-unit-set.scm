#lang sicp

;; ordered
(define (union-set set1 set2)
  (cond ((null? set2) set1)
        ((null? set1) set2)
        (else (let ((x1 (car set1))
                    (x2 (car set2)))
                (cond ((= x1 x2)
                       (cons x1 (union-set (cdr set1)
                                           (cdr set2))))
                      ((> x2 x1)
                       (cons x1 (union-set (cdr set1)
                                           set2)))
                      ((< x2 x1)
                       (cons x2 (union-set set1
                                           (cdr set2)))))))))
        
        
;; test
(union-set (list 1 2 3 5 7 9) (list 2 4 6 8 10))
(union-set (list 1 3 5 7 9) (list 2 4 6 8 10))
(union-set (list 1 3 5 7 9) '())
(union-set '() (list 2 4 6 8 10))
(union-set '() '())
