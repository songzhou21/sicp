#lang planet neil/sicp
(define (square x)
    (* x x))

(define (good-enough? guess x)
	;(display "guess:") (display guess) (display "x")(display x)(display "result:") (display (abs (- (square guess) x)))(newline)
    (< (abs (- (square guess) x)) 0.01))

(define (average x y)
    (/ (+ x y) 2))

(define (improve guess x)
    (average guess (/ x guess)))

(define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
		(sqrt-iter (improve guess x) x)
	)
)

(define (sqrt x)
	(sqrt-iter 1.0 x))
	

(sqrt 9)

