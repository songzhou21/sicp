#lang sicp

(define (reverse items)
  (define (reverse-iter items result)
    (if (null? items) result
        (reverse-iter (cdr items)
                      (cons (if (pair? (car items))
                                (reverse (car items))
                                (car items))
                            result))))
  (reverse-iter items nil))

(reverse (list (list 1 2) (list 3 4)))
