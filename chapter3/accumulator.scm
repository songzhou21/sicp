(define (make-accumulator initial)
    (lambda (number) 
        (set! initial 
            (+ initial number))
        initial))

(define A (make-accumulator 5))

(A 10)
(A 10)