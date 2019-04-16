(load "21-smallest-divisor.scm")

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (real-time-clock))
  )

(define (start-prime-test n start-time)
  (if (prime? n)
    (report-time (- (real-time-clock) start-time))
    )
  )

(define (report-time elapsed-time)
  (display " *** ")
  (display elapsed-time)
  )

(define (primes-iter n count)
  (cond ((= count 0))
        ((prime? n)
         (primes-iter (next-odd n) (- count 1))
         )
        (else 
          (primes-iter (next-odd n) count)
          )
        )
  )

(define (search-for-primes n)
  (let ((start-time (real-time-clock)))
    (primes-iter n 3)
    (- (real-time-clock) start-time)
    )
  )

(define (next-odd n)
  (if (odd? n)
    (+ n 2)
    (+ n 1)
    )
  )

(search-for-primes 1000)
(search-for-primes 10000)
(search-for-primes 100000)
(search-for-primes 1000000)

