(load "6-new-if.scm")
(load "p15-sqrt-iter.scm")

(define (new-if-sqrt-iter guess x)
  (new-if (good-enough? guess x) 
    guess
    (new-if-sqrt-iter (improve guess x) x))
)