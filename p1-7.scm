(define (square x)
    (* x x))

(define (good-enough? old_guess new_guess)
    (> 0.01
        (/ (abs (- old_guess new_guess))
            old_guess)))

(define (average x y)
    (/ (+ x y) 2))

(define (improve guess x)
    (average guess (/ x guess)))

(define (sqrt-iter guess x)xo
    (If (good-enough? guess (improve guess x))
        (improve guess x)
        (sqrt-iter (improve guess x)
            x)))
