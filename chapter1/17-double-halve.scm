; multi
;(* 2 3)
;(+ 2 (* 2 2))
;(+ 2 (+ 2 (* 2 1)))
;(+ 2 (+ 2 (+ 2 (* 2 0))))
;
;
;f(2,3)
;f(2,f(2*2))
;
;

; f(a,b)
; b odd?    a+f(a,b-1)
;
; b even?   2*f(a,b/2)
;
; f(2,3)
; 2 + f(2,2)
; 2 + 2*f(2,1)
; 2 + 2*(2+f(2,0))

(define (halve n)
  (/ n 2)
  )

(define (double n)
  (+ n n)
 )

(define (multi a b)
  (cond ((= b 0)
         0)
        ((even? b)
         (double (multi a
                        (halve b)
                        )))
        ((odd? b)
         (+ a
            (multi a
                   (- b 1))))
        )
  )
