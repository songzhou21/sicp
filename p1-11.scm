#lang sicp

(define	(f n)
  (cond ((< n 3 ) n)
        (else (+ (f (- n 1)) 
                 (* 2 (f (- n 2)))
                 (* 3 (f (- n 3)))
                 )
              )
        )
  )

(f 1)
(f 2)
(f 4)
(f 5)