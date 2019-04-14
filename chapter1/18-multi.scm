; 2*5
; f(a,b,product) 
; f(2,5,0) ;a,b-1,product+a
; f(2,4,2) ;a*2,b/2,product
; f(4,2,2) 
; f(8,1,2)
; f(8,0,10)


; f(2,7,0)
; f(2,6,2)
; f(4,3,2)
; f(4,2,6)
; f(8,1,6)
; f(8,0,14)

(load "17-double-halve.scm")

(define (multi-iter a b product)
  (cond ((= b 0)
        product)
        ((even? b)
         (multi-iter (double a) (halve b) product))
        ((odd? b)
         (multi-iter a (- b 1) (+ product a))
         )
        )
 )

(define (multi a b)
  (multi-iter a b 0)
  )
