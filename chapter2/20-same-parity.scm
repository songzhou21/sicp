#lang sicp

(define (same-property first)
  (lambda (n)
    (if (odd? first)
        (odd? n)
        (even? n))))

(define (same-parity-iter first remain)
  (cond ((null? remain) nil)
        (((same-property first)
          (car remain))
         (cons (car remain)
               (same-parity-iter first (cdr remain))))
        (else (same-parity-iter first (cdr remain)))))

(define (same-parity first . remain)
  (cons first
        (same-parity-iter first remain)))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7 8)