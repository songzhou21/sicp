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

#|
(reverse-iter (list 1 4 9 16 25) nil)
(reverse-iter (list 4 9 16 25) (cons 1 nil))
(reverse-iter (list 9 16 25) (cons 4 (cons 1 nil))))
|#
