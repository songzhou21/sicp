(load "p15-sqrt-iter.scm")

(define (new-good-enough? old-guess new-guess)
  (> 0.01 
    (/ (abs (- old-guess new-guess))
    old-guess)
  )
)

(define (sqrt-iter guess x)
    (if (new-good-enough? guess (improve guess x))
        (improve guess x)
        (sqrt-iter (improve guess x) x)
    )
)
