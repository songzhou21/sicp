(load "22-timed-prime-test.scm")

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n)
         n
         )
        ((divides? test-divisor n)
         test-divisor
         )
        (else (find-divisor
                n
                (next test-divisor))
         )
        )
  )


(define (next n)
  (if (= 2 n)
    3
    (+ n 2)
    )
  )

(define (divides? a b)
  (= (remainder b a) 0)
  )

(define (prime? n)
  (= n (smallest-divisor n))
  )

(search-for-primes 1000)
(search-for-primes 10000)
(search-for-primes 100000)
(search-for-primes 1000000)
