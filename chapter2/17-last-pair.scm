#lang sicp

(define (last-pair items)
  (cond ((null? items) (error "list empty"))
        ((null? (cdr items)) items)
        (else
         (last-pair (cdr items))
         )
        )
  )


#;(last-pair (list))
(last-pair (list 1))
(last-pair (list 1 2 3))
(last-pair (list 23 72 149 34))