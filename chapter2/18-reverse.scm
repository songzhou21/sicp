#lang sicp

(define (reverse items)
  (define (reverse-iter items result)
    (if (null? items)
        result
        (reverse-iter (cdr items) (cons (car items) result))
      )
    )

  (reverse-iter items nil)
  )

(reverse (list 1 4 9 16 25))
