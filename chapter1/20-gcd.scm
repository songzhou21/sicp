(dt3efine (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))
    )
  )

; Applicative-order
(gcd 206 40)    
(gcd 40 6)      (gcd 40 (remainder 206 40))
(gcd 6 4)       (gcd 6 (remainder 40 6))
(gcd 4 2)       (gcd 4 (remainder 6 4))
(gcd 2 0)       (gcd 2 (remainder 4 2))
2


; Normal-order
;                                                                           eval-conditon reduce
;1(gcd 206 40)                                                                     0        0
;2(gcd 40 (remainder 206 40)) ; a = 40, b = 6, t1 = (remainder 206 40)             1         1
;(if (= t1 0) ...)   ; #f 1                                          
;3(gcd t1 (remainder 40 t1))  ; a = 6, b = 4, t2 = (remainder 40 t1)               2         1
;(if (= t2 0) ...)   ; #f                                           
;4(gcd t2 (remainder t1 t2))  ; a = 4, b = 2, t3 = (remainder t1 t2)               4         1
;(if (= t3 0) ...)   ; #f                                            
;5(gcd t3 (remainder t2 t3))  ; a = 2, b = 0, t4 = (remainder t2 t3)               7         1
(if (= t4 0) ...)   ; #t                                            

t3

(remainder t1 t2)
(remainder t1 
           (remainder 40 t1)) ; t2
(remainder t1 
           (remainder 40 
                      (remainder 206 40))) ; t1
(remainder t1 
           (remainder 40 6))
(remainder t1 4)
(remainder (remainder 206 40) 4)
(remainder 6 4)
;2


(remainder (remainder 206 40) (remainder 40 (remainder 206 40))) ;4

; condition: 1+2+4+7 = 14, reduce: 4, sum: 18


; Formula
;R = SUM(i from 1 to n, fib(i) + fib(i - 1)) - 1 
;5 f(5)+f(4) 3
;3 f(4)+f(3) 2
;2 f(3)+f(2) 1
;1 f(2)+f(1) 1
;1 f(1)+f(0) 0
