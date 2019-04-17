(define (expmod base exp m)                                                                                                                                                         
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))        


(define (fermat-test n a)
  (= (expmod a n n) a))


(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n (- times 1)) (fast-prime? n (- times 1)))
        (else false)))

(define (carmichael-number? n)
  (fast-prime? n n)
  )

(carmichael-number? 561)
(carmichael-number? 1105)
(carmichael-number? 1729)
(carmichael-number? 2465)
(carmichael-number? 2821)
(carmichael-number? 6601)
(carmichael-number? 3)
(carmichael-number? 4)
